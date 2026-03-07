from fastapi import FastAPI, WebSocket, WebSocketDisconnect

from services.llm_service import LLMService
from services.sort_source_service import SortSourceService
from services.search_service import SearchService

app = FastAPI()

search_service = SearchService()
sort_source_service = SortSourceService()
llm_service = LLMService()


@app.websocket("/ws/chat")
async def websocket_chat_endpoint(websocket: WebSocket):

    await websocket.accept()

    chat_history = []

    try:
        while True:

            data = await websocket.receive_json()
            query = data.get("query")

            if not query:
                await websocket.send_json({
                    "type": "error",
                    "data": "Query is missing"
                })
                continue

            # save user message
            chat_history.append({
                "role": "user",
                "content": query
            })

            # search web
            search_results = search_service.web_search(query)

            # rerank
            sorted_results = sort_source_service.sort_sources(query, search_results)

            # send sources once
            await websocket.send_json({
                "type": "sources",
                "data": [
                    {
                        "title": r["title"],
                        "url": r["url"]
                    }
                    for r in sorted_results[:5]
                ]
            })

            full_answer = ""

            # stream LLM response
            for chunk in llm_service.generate_response(query, sorted_results, chat_history):

                full_answer += chunk

                await websocket.send_json({
                    "type": "content",
                    "data": chunk
                })

            # save assistant reply
            chat_history.append({
                "role": "assistant",
                "content": full_answer
            })

            # keep only last 10 messages
            chat_history = chat_history[-10:]

            await websocket.send_json({
                "type": "done"
            })

    except WebSocketDisconnect:
        print("Client disconnected")

    except Exception as e:
        print("Unexpected error:", e)

    finally:
        await websocket.close()