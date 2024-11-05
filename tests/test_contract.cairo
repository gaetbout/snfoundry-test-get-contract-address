use snfoundry_test_get_contract_address::{
    TestInterfaceDispatcher, TestInterfaceDispatcherTrait, test
};

use snforge_std::{
    declare, ContractClassTrait, start_cheat_caller_address_global, DeclareResultTrait
};

#[test]
fn test_simple() {
    let class_hash = *declare("TestContract").unwrap().contract_class();
    let (contract_address, _) = class_hash.deploy(@array![]).unwrap();
    start_cheat_caller_address_global(contract_address);
    let contract = TestInterfaceDispatcher { contract_address };
    // This is the expected value that is coming from
    // https://github.com/foundry-rs/starknet-foundry/blob/221b1dbff42d650e9855afd4283508da8f8cacba/snforge_std/src/cheatcodes.cairo#L31
    assert_eq!(test().try_into().unwrap(), 469394814521890341860918960550914);
    assert_eq!(contract.test(), test());
}
