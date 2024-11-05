use starknet::{get_contract_address, ContractAddress};

#[starknet::interface]
pub trait TestInterface<TContractState> {
    fn test(self: @TContractState) -> ContractAddress;
}

pub fn test() -> ContractAddress {
    get_contract_address()
}

#[starknet::contract]
mod TestContract {
    use starknet::ContractAddress;

    #[storage]
    struct Storage {}
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {}

    #[abi(embed_v0)]
    impl IImpl of super::TestInterface<ContractState> {
        fn test(self: @ContractState) -> ContractAddress {
            super::test()
        }
    }
}
