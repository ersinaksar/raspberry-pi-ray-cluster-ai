import ollama
import ray
import sys
print(sys.path)
# start ray
ray.init(address='auto')

# upload TinyLlama model 


@ray.remote
class TinyLlamaModel:
    def __init__(self):
        # Settings.llm = Ollama(model="tinyllama", request_timeout=60.0)
        # self.llm = Ollama(model="tinyllama", request_timeout=60.0)
        pass

    def predict(self, input_text):
        prompt = {"input": input_text}
        # return Settings.llm.predict(prompt)
        # return self.llm.predict(prompt)
        # return llm.predict(prompt)
        response = ollama.chat(model='tinyllama', messages=[
            {
                'role': 'user',
                'content': input_text,
            },
        ])
        return response


def main():
    # llm = Ollama(model="tinyllama")
    input_text = sys.stdin.read().strip()

    # create Model instance and start to precess input
    tiny_llama = TinyLlamaModel.remote()
    response = ray.get(tiny_llama.predict.remote(input_text))

    print(response)


if __name__ == "__main__":
    main()
