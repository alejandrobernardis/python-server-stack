var _start = Date();
printjson({date: _start, status: 'Start'});

var _i, 
    _db = db.getSiblingDB('admin'), 
    _role = [{
        db: 'track', 
        role: 'readWrite'
    }],
    _user, 
    _users = [{
        user: 'sysadmin', 
        pwd: 'password', 
        customData: {'first_name': 'System', 'last_name': 'Administrator', 'email': 'sysadmin@localhost'}, 
        roles: ['root']
    }, {
        user: 'backend', 
        pwd: 'password', 
        customData: {'first_name': 'Backend', 'last_name': 'Administrator', 'email': 'backend@localhost'}, 
        roles: _role
    }, {
        user: 'backoffice', 
        pwd: 'password', 
        customData: {'first_name': 'Backoffice', 'last_name': 'Administrator', 'email': 'backoffice@localhost'}, 
        roles: _role
    }]; 

printjson({date: Date(), status: 'Users/Roles'});

for(_i in _users){
    _user = _users[_i];
    _db.createUser(_user);
    if(_user.user == 'sysadmin'){
        _db.auth(_user.user, _user.pwd);
    }
}

printjson({start: _start, end: Date(), status: 'Complete'});
quit();
