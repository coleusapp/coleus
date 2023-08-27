import{T as d,o as u,c as p,a as t,b as l,w as f,u as e,e as n,F as c,g as i,i as x}from"./app-04b0c30d.js";import{_ as m,a as g,A as w,h as r}from"./index.m-65dc1fe2.js";const _={class:"flex flex-col justify-center py-12 sm:px-6 lg:px-8 min-h-screen bg-gray-50"},v=l("div",{class:"sm:mx-auto sm:w-full sm:max-w-md"},[l("h2",{class:"mt-6 text-3xl font-extrabold text-center text-gray-900"}," Register ")],-1),V={class:"sm:mx-auto mt-8 sm:w-full sm:max-w-md"},y={class:"py-8 px-4 sm:px-10 bg-white sm:rounded-lg shadow"},b={class:"flex justify-center items-center"},h={class:"text-sm"},A={__name:"TheRegister",props:{github:String,google:String},setup(R){let s=d({email:null,password:null,password_confirmation:null,name:null});return(N,a)=>(u(),p(c,null,[t(w,{title:"Register"}),l("div",_,[v,l("div",V,[l("div",y,[l("form",{action:"#",class:"space-y-6",onSubmit:a[4]||(a[4]=f(o=>e(s).post(e(r)("postRegisterWithEmail")),["prevent"]))},[l("div",null,[t(m,{modelValue:e(s).name,"onUpdate:modelValue":a[0]||(a[0]=o=>e(s).name=o),form:e(s),label:"Name",name:"name"},null,8,["modelValue","form"])]),l("div",null,[t(m,{modelValue:e(s).email,"onUpdate:modelValue":a[1]||(a[1]=o=>e(s).email=o),form:e(s),label:"Email",name:"email",type:"email"},null,8,["modelValue","form"])]),l("div",null,[t(m,{modelValue:e(s).password,"onUpdate:modelValue":a[2]||(a[2]=o=>e(s).password=o),form:e(s),label:"Password",name:"password",type:"password"},null,8,["modelValue","form"])]),l("div",null,[t(m,{modelValue:e(s).password_confirmation,"onUpdate:modelValue":a[3]||(a[3]=o=>e(s).password_confirmation=o),form:e(s),label:"Password confirmation",name:"password_confirmation",type:"password"},null,8,["modelValue","form"])]),l("div",b,[l("div",h,[t(e(x),{href:e(r)("getLoginForm"),class:"font-medium text-indigo-600 hover:text-indigo-500"},{default:n(()=>[i(" Already have an account? ")]),_:1},8,["href"])])]),l("div",null,[t(g,{disabled:e(s).processing,form:e(s),class:"flex justify-center py-2 px-4 w-full",type:"submit"},{default:n(()=>[i(" Register ")]),_:1},8,["disabled","form"])])],32)])])])],64))}};export{A as default};
