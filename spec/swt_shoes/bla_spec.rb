describe 'bla' do

  subject {"bla"}
  
  its(:length) {p self.__its_subject; should eq 3}
  its(:object_id) {p self.__its_subject; should_not eq 3}
  its(:hash) {p self.__its_subject; should_not eq 3}
end
