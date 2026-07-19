<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login | Smart Grocery</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Inter',sans-serif;
}

:root{

--green:#22c55e;
--greenDark:#16a34a;
--border:rgba(255,255,255,.08);
--card:#1b1b1b;
--text:#ffffff;
--soft:rgba(255,255,255,.65);

}

body{

height:100vh;
display:flex;
justify-content:center;
align-items:center;

background:
linear-gradient(rgba(0,0,0,.72),rgba(0,0,0,.72)),
url("images/carousel1.jpg");

background-size:cover;
background-position:center;

}

.login-box{

width:430px;
background:#1b1b1b;
border:1px solid rgba(255,255,255,.08);
border-radius:22px;
padding:40px;

box-shadow:
0 25px 60px rgba(0,0,0,.45);

backdrop-filter:blur(20px);

}

.logo{

display:flex;
align-items:center;
gap:12px;
margin-bottom:35px;

}

.logo-icon{

width:42px;
height:42px;
background:var(--green);
border-radius:10px;

display:flex;
justify-content:center;
align-items:center;

font-size:20px;

}

.logo span{

font-size:22px;
font-weight:800;
color:white;

}

h2{

font-size:36px;
font-weight:800;
color:white;

}

.subtitle{

margin-top:8px;
margin-bottom:30px;

color:var(--soft);

}

label{

display:block;
margin-bottom:8px;
margin-top:18px;

font-size:14px;
font-weight:600;

color:white;

}

input{

width:100%;
padding:15px;

background:#262626;

border:1px solid rgba(255,255,255,.08);

border-radius:12px;

color:white;
font-size:15px;

outline:none;

transition:.3s;

}

input:focus{

border-color:var(--green);

}

input::placeholder{

color:#888;

}

.options{

display:flex;
justify-content:space-between;
align-items:center;

margin-top:18px;
margin-bottom:22px;

font-size:14px;

color:var(--soft);

}

.options a{

color:var(--green);
text-decoration:none;

}

.options a:hover{

text-decoration:underline;

}

button{

width:100%;
padding:15px;

background:var(--green);

border:none;
border-radius:12px;

font-size:17px;
font-weight:700;

color:white;

cursor:pointer;

transition:.3s;

}

button:hover{

background:var(--greenDark);

transform:translateY(-2px);

}

.error{

margin-bottom:18px;

padding:12px;

background:rgba(255,0,0,.12);

border:1px solid rgba(255,0,0,.3);

border-radius:10px;

color:#ff8080;

font-size:14px;

}

.bottom{

margin-top:28px;

text-align:center;

font-size:14px;

color:var(--soft);

}

.bottom a{

color:var(--green);

font-weight:600;

text-decoration:none;

}

.bottom a:hover{

text-decoration:underline;

}

.home{

margin-top:25px;
text-align:center;

}

.home a{

color:#aaa;
text-decoration:none;

}

.home a:hover{

color:white;

}

</style>

</head>

<body>

<div class="login-box">

<div class="logo">

<div class="logo-icon">
🛒
</div>

<span>Smart Grocery</span>

</div>

<h2>Welcome Back</h2>

<p class="subtitle">
Sign in to your Smart Grocery account
</p>

<%
String error=(String)request.getAttribute("error");

if(error!=null){
%>

<div class="error">
<%=error%>
</div>

<%
}
%>

<form action="LoginServlet" method="post">

<label>Email Address</label>

<input
type="email"
name="email"
placeholder="you@email.com"
required>

<label>Password</label>

<input
type="password"
name="password"
placeholder="Enter your password"
required>

<div class="options">

<label>

<input type="checkbox"
style="width:auto;margin-right:6px;accent-color:#22c55e;">

Remember me

</label>

<a href="#">
Forgot Password?
</a>

</div>

<button type="submit">

Sign In →

</button>

</form>

<div class="bottom">

Don't have an account?

<a href="register.jsp">

Create one free

</a>

</div>

<div class="home">

<a href="index.jsp">

← Back to Home

</a>

</div>

</div>

</body>

</html>