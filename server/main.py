from fastapi import FastAPI

from pydantic_models.chat_body import ChatBody
from search_service import SearchService


app = FastAPI()


#/chat?quary =who%20is%20Pranay

search_service = SearchService()


#chat
@app.post("/chat")
def char_endpoint(body: ChatBody):
   search_service.web_search(body.query)
   #sort the sorces
   #generate the response using LLM
   return body.query