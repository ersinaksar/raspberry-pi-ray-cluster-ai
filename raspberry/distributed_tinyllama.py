

import sys
print(sys.path)
import ray

# from llama_index.llms.ollama import Ollama
# from llama_index.core import Settings
from llama_index.legacy.llms.ollama import Ollama
import sys

# Ray'ı başlat
ray.init(address='auto')

# TinyLlama modeli yükle
@ray.remote
class TinyLlamaModel:
    def __init__(self):
        # Settings.llm = Ollama(model="tinyllama", request_timeout=60.0)
        self.llm = Ollama(model="tinyllama", request_timeout=60.0)

    def predict(self, input_text):
        prompt = {"input": input_text}
        # return Settings.llm.predict(prompt)
        return self.llm.predict(prompt)

def main():
    input_text = sys.stdin.read().strip()

    # Model instance'ı oluştur ve input'u işlemeye başla
    tiny_llama = TinyLlamaModel.remote()
    response = ray.get(tiny_llama.predict.remote(input_text))

    print(response)

if __name__ == "__main__":
    main()
