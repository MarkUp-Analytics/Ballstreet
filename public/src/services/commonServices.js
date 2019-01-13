export default{
    validEmail: function(email) {
        var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    },
    isEmpty: function(str){
        if(!str){
            return true;
        }
        else if(typeof str === 'string' && str.trim().length === 0){
            return true;
        }
        else{
            return false;
        }
    }
}