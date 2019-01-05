import axios from 'axios';

export default ()=>{
    return axios.create({
        // baseURL: `https://9vcou25xv3.execute-api.us-east-1.amazonaws.com/dev/`
        // baseURL: `http://localhost:8081/`
        baseURL: `http://54.84.205.29:8081` //dev ec2
    })
}