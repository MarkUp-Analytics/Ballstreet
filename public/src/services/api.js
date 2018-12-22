import axios from 'axios';

export default ()=>{
    return axios.create({
        // baseURL: `https://9vcou25xv3.execute-api.us-east-1.amazonaws.com/dev/`
        baseURL: `http://localhost:8081/`
    })
}