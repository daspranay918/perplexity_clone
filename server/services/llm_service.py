import google.generativeai as genai
import os

from config import Settings

settings = Settings()

class LLMService:
    def __init__(self):
        genai.configure(api_key=settings.GEMINI_API_KEY)
        self.model = genai.GenerativeModel("gemini-1.5-pro")

    def generate_response(self, query: str, search_results: list[dict]):

        