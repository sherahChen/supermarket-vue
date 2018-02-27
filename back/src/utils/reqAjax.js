/*
* @Author: Marte
* @Date:   2017-12-07 17:33:59
* @Last Modified by:   Marte
* @Last Modified time: 2018-01-19 18:41:20
*/
import axios from 'axios';
import qs from 'qs';
import Url from './baseUrl'

var baseUrl = Url.url;
// var baseUrl = 'http://10.3.136.49:555/';
// var baseUrl = 'http://10.3.136.55:999/';

var fliterUrl = function(url){
    if(url.startsWith('http')){
        return url;
    }
    return baseUrl + url;
}
export default {
    get:(opt)=>{
        return  new Promise((resolve,reject)=>{
                    if(opt.ve){
                        opt.ve['loading'] = true;
                    }
                    axios.get(fliterUrl(opt.url)).then((response)=>{
                        if(opt.ve){
                            opt.ve['loading'] = false;
                        }
                        resolve(response);
                    }).catch((error)=>{
                        if(opt.ve){
                            opt.ve['loading'] = false;
                        }
                        reject(error);
                    })
                })
    },
    post:(opt)=>{
        return new Promise((reslove,reject)=>{
                 axios({
                    url:fliterUrl(opt.url),
                    data: qs.stringify(opt.parmas),
                    method: 'post',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    }
                }).then((response) => {
                       reslove(response);
                    })
                    .catch((error) => {
                       reject(error);
                    }
                );
        })
    }
}
