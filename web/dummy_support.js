// dummy_support.js
export async function compileStreaming(responsePromise) {
  const response = await responsePromise;
  const buffer = await response.arrayBuffer();
  const module = await WebAssembly.compile(buffer);

  return {
    async instantiate(imports = {}) {
      // Ensure required WASM imports exist
      if (!imports["dart2wasm"]) {
        imports["dart2wasm"] = {};
      }

      if (!imports["wasm:js-string"]) {
        imports["wasm:js-string"] = {
          newString: () => console.log("wasm:js-string.newString() called (dummy)"),
          stringLength: () => 0,
          stringAt: () => 0
        };
      }

      if (!imports["Math"]) {
        imports["Math"] = Math;
      }

      // 🔥 Ensure all required functions exist in dart2wasm
      Object.assign(imports["dart2wasm"], {
        _1599: () => console.log("dart2wasm._1599() called (dummy function)"),
        _1600: () => console.log("dart2wasm._1600() called (dummy function)")
      });

      const instance = await WebAssembly.instantiate(module, imports);
      return {
        invokeMain: function () {
          if (instance.exports.main) {
            instance.exports.main();
          } else {
            console.log("invokeMain called - No main function found in WASM module.");
          }
        }
      };
    }
  };
}
