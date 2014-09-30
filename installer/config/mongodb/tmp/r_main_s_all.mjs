var _start = Date();
printjson({date: _start, status: 'Start'});

var _i, 
    _db = db.getSiblingDB('admin'), 
    _role = [{
        db: 'main', 
        role: 'readWrite'
    }],
    _user, 
    _users = [{
        user: 'sysadmin', 
        customData: {'first_name': 'System', 'last_name': 'Administrator', 'email': 'sysadmin@localhost'}, 
        pwd: 'password', 
        roles: ['root']
    }, {
        user: 'backend', 
        customData: {'first_name': 'Backend', 'last_name': 'Administrator', 'email': 'backend@localhost'}, 
        pwd: 'password', 
        roles: _role
    }, {
        user: 'backoffice', 
        customData: {'first_name': 'Backoffice', 'last_name': 'Administrator', 'email': 'backoffice@localhost'}, 
        pwd: 'password', 
        roles: _role
    }],
    _config = {
        _id: "rs_main",
        members:[{
            _id: 0,
            host: "127.0.0.1:27000",
            priority: 3
        }, {
            _id: 1,
            host: "127.0.0.1:27001",
            priority: 2
        }, {
            _id: 2,
            host: "127.0.0.1:27002",
            priority: 1
        }, {
            _id: 3,
            host: "127.0.0.1:27003",
            priority: 0,
            slaveDelay: 28800,
            hidden: true
        }]
    };

printjson({date: Date(), status: 'ReplicaSet'});
rs.initiate(_config);
rs.status();

printjson({date: Date(), status: 'Users/Roles'});
while(true){
    if(rs.isMaster().ismaster){
        for(_i in _users){
            _user = _users[_i];
            _db.createUser(_user);
            if(_user.user == 'sysadmin'){
                _db.auth(_user.user, _user.pwd);
            }
        }
        break;
    }else{
        printjson({date: Date(), status: 'Pending'});
    }
}

printjson({start: _start, end: Date(), status: 'Complete'});
quit();
