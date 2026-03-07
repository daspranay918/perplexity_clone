import requests
import json

from config import Settings

settings = Settings()


class LLMService:

    def __init__(self):
        self.api_key = settings.OPENROUTER_API_KEY
        self.url = "https://openrouter.ai/api/v1/chat/completions"

    def generate_response(self, query: str, search_results: list[dict], chat_history):

        context_text = "\n\n".join([
            f"Source {i+1}: {result['url']}\n{result['content'][:1500]}"
            for i, result in enumerate(search_results)
            if result.get("content")
        ])
        
        # handle empty search results
        if not context_text:
            yield "I couldn't find reliable sources for this query. Please try rephrasing it."
            return

        system_prompt = f"""
You are an AI research assistant.

Use the web sources below to answer the question.

WEB SOURCES
-----------
{context_text}

INSTRUCTIONS
------------
- Use only the sources above
- Cite sources like (Source 1), (Source 2)
- Do not invent information
- Combine multiple sources if needed
- Write a clear and structured answer
"""

        messages = [
            {"role": "system", "content": system_prompt}
        ]

        # add conversation history
        messages.extend(chat_history)

        response = requests.post(
            self.url,
            headers={
                "Authorization": f"Bearer {self.api_key}",
                "Content-Type": "application/json"
            },
            json={
                "model": "deepseek/deepseek-chat",
                "messages": messages,
                "stream": True
            },
            stream=True
        )

        for line in response.iter_lines():

            if not line:
                continue

            decoded = line.decode("utf-8")

            if decoded.startswith("data: "):

                data = decoded.replace("data: ", "")

                if data == "[DONE]":
                    break

                try:
                    json_data = json.loads(data)
                    delta = json_data["choices"][0]["delta"]

                    if "content" in delta:
                        yield delta["content"]

                except Exception:
                    continue