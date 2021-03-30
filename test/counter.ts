import { Client, Provider, ProviderRegistry, Result } from "@blockstack/clarity";
import { assert } from "chai";

describe("counter contract test suite", () => {
  let actionClient: Client;
  let provider: Provider;
  before(async () => {
    provider = await ProviderRegistry.createProvider();
    actionClient = new Client("SP3GWX3NE58KXHESRYE4DYQ1S31PQJTCRXB3PE9SB.ardkonUSD", "ardkonUSD", provider);
  });
  it("should have a valid syntax", async () => {
    await actionClient.checkContract();
  });
  describe("deploying an instance of the contract", () => {
    const getCounter = async () => {
      const query = actionClient.createQuery({
        method: { name: "get-contract-principle", args: [] }
      });
      const receipt = await actionClient.submitQuery(query);
      const result = Result.unwrapInt(receipt);
      return result;
    }
    /*
    const execMethod = async (method: string) => {
      const tx = counterClient.createTransaction({
        method: {
          name: method,
          args: [],
        },
      });
      await tx.sign("SP2J6ZY48GV1EZ5V2V5RB9MP66SW86PYKKNRV9EJ7");
      const receipt = await counterClient.submitTransaction(tx);
      return receipt;
    }
    before(async () => {
      await counterClient.deployContract();
    });
    it("should start at zero", async () => {
      const counter = await getCounter();
      assert.equal(counter, 0);
    })
    it("should increment", async () => {
      await execMethod("increment");
      assert.equal(await getCounter(), 1);
      await execMethod("increment");
      assert.equal(await getCounter(), 2);
    })
    it("should decrement", async () => {
      await execMethod("decrement");
      assert.equal(await getCounter(), 1);
      await execMethod("decrement");
      assert.equal(await getCounter(), 0);
    })*/
  });
  
  after(async () => {
    await provider.close();
  });
});
