use starknet::ContractAddress;

#[starknet::interface]

trait CourseTrait<TContractState>{
    fn enroll(ref self: TContractState, email: felt252, fee: u256, student_balance: u256) ;
    fn do_exam(self: @TContractState, email: felt252);
    fn retake(self: @TContractState);
    fn withdraw_refund( self: @TContractState, amount: u256);
    fn get_certified(self: @TContractState);
    
    fn check_student_status(self: @TContractState, contract_address: ContractAddress) ;
}

#[starknet::contract]

mod CourseContract{
    use starknet::ContractAddress;
    use starknet::get_caller_address;

    #[storage]
    struct Storage{
        student: Student,
        total_students: u128,
        owner: Owner,
    }

    #[constructor]
    fn constructor(
        ref self: ContractState,
        caller: Owner,
        student: Student
    ){
        self.owner.write(caller);
        self.total_students.write(1);
        self.student.write(student);
        

    }

    #[derive(Drop, Copy, Serde, starknet::store, storage_access::StorageAccess)]
    struct Student{
        address: ContractAddress,
        email: felt252,
        isEnrolled: bool,
        takenExam: bool,
        isCertified: bool,
        balance: u256,

    }


    #[derive(Drop, Copy, Serde, starknet::store, storage_access::StorageAccess)]     
    struct Owner{
        email: felt252,
        contract_address: ContractAddress,
    }

    #[external(v0)]
impl ICourseTrait of super::CourseTrait<ContractState>{
    fn enroll(ref self: ContractState, email: felt252, fee: u256, student_balance: u256){
        let caller = get_caller_address();
        let new_student = Student{
            address: caller,
            email: email,
            isEnrolled: true,
            takenExam: false,
            isCertified: false,
            balance: student_balance,
        };
        self.student.write(new_student);



    }
    fn do_exam(self: @ContractState, email: felt252){

    }
    fn retake(self: @ContractState){

    }
    fn withdraw_refund(self: @ContractState, amount: u256){
    


    }
    fn get_certified(self: @ContractState){

    }
    
    fn check_student_status(self: @ContractState, contract_address: ContractAddress) {

    }

}

//More functionality to be added

}