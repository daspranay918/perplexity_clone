from fastapi import FastAPI

from pydantic_models.chat_body import ChatBody
from services.sort_source_service import SortSourceService
from services.search_service import SearchService


app = FastAPI()


#/chat?quary =who%20is%20Pranay

search_service = SearchService()
sort_source_service = SortSourceService()


#chat
@app.post("/chat")
def char_endpoint(body: ChatBody):
   search_results = search_service.web_search(body.query)
   sorted_results = sort_source_service.sort_sources(body.query, search_results)
   print(sorted_results)
   #generate the response using LLM
   return body.query