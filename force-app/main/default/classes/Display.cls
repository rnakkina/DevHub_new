public with sharing class Display {
    public string userfstname;
    public string userlstname;
    public integer age;
    public date DOB;
    public string position;
    public void display_val()
    {
        system.debug('First Name:' +userfstname);
        system.debug('Last Name:' +userlstname);
        system.debug('age:' +age);
        system.debug('FDOB:' +DOB);
        system.debug('position:' +position);
    }
}
