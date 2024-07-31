import ray
from ollama import TinyLLama
import sys

# Ray'ı başlat
ray.init(address='auto')

# TinyLLama modeli yükle
@ray.remote
class TinyLlamaModel:
    def __init__(self):
        self.model = TinyLLama()

    def predict(self, input_text):
        return self.model.predict(input_text)

def main():
    input_text = sys.stdin.read().strip()

    # Model instance'ı oluştur ve input'u işlemeye başla
    tiny_llama = TinyLlamaModel.remote()
    response = ray.get(tiny_llama.predict.remote(input_text))

    print(response)

if __name__ == "__main__":
    main()
