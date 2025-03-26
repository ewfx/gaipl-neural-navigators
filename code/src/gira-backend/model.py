import google.generativeai as genai
import os

# Configure the Gemini API key
genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

# List available models
models = genai.list_models()

# Print the model IDs
for model in models:
    print(model.name)

