<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Create Account | Smart Grocery</title>

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
--green-dark:#16a34a;
--card:#1b1b1b;
--border:rgba(255,255,255,.08);
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

.register-box{

width:460px;

background:rgba(27,27,27,.95);

border:1px solid var(--border);

border-radius:22px;

padding:40px;

backdrop-filter:blur(18px);

box-shadow:0 25px 60px rgba(0,0,0,.45);

}

.logo{

display:flex;
align-items:center;
gap:12px;

margin-bottom:30px;

}

.logo-icon{

width:42px;
height:42px;

background:var(--green);

border-radius:10px;

display:flex;
align-items:center;
justify-content:center;

font-size:20px;

}

.logo span{

font-size:22px;
font-weight:800;
color:white;

}

h2{

color:white;

font-size:34px;

font-weight:800;

margin-bottom:8px;

}

.subtitle{

color:var(--soft);

margin-bottom:28px;

font-size:15px;

}

label{

display:block;

margin-bottom:8px;

margin-top:18px;

font-size:14px;

font-weight:600;

color:white;

}

input,
select{

width:100%;

padding:14px;

background:#262626;

border:1px solid rgba(255,255,255,.08);

border-radius:12px;

color:white;

font-size:15px;

outline:none;

transition:.25s;

}

input:focus,
select:focus{

border-color:var(--green);

background:#2b2b2b;

}

input::placeholder{

color:#888;

}

select option{

background:#1b1b1b;
color:white;

}

button{

width:100%;

padding:15px;

margin-top:28px;

background:var(--green);

border:none;

border-radius:12px;

font-size:16px;

font-weight:700;

color:white;

cursor:pointer;

transition:.3s;

}

button:hover{

background:var(--green-dark);

transform:translateY(-2px);

}

.error{

background:rgba(239,68,68,.12);

border:1px solid rgba(239,68,68,.3);

color:#ff7b7b;

padding:12px;

border-radius:10px;

margin-bottom:18px;

font-size:14px;

text-align:center;

}

.success{

background:rgba(34,197,94,.12);

border:1px solid rgba(34,197,94,.3);

color:#4ade80;

padding:12px;

border-radius:10px;

margin-bottom:18px;

font-size:14px;

text-align:center;

}

.bottom{

margin-top:24px;

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

margin-top:18px;

text-align:center;

}

.home a{

color:#9ca3af;

text-decoration:none;

font-size:14px;

}

.home a:hover{

color:white;

}

</style>

</head>

<body>

<div class="register-box">

<div class="logo">

<div class="logo-icon">
🛒
</div>

<span>Smart Grocery</span>

</div>

<h2>Create Account</h2>

<p class="subtitle">
Join Smart Grocery and start managing your groceries smarter.
</p>

<%
String error=(String)request.getAttribute("error");
String success=(String)request.getAttribute("success");

if(error!=null){
%>

<div class="error">
<%=error%>
</div>

<%
}

if(success!=null){
%>

<div class="success">
<%=success%>
</div>

<%
}
%>

<form action="RegisterServlet" method="post">

<label>Full Name</label>

<input
type="text"
name="name"
placeholder="Enter your full name"
required>

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
placeholder="Create a password"
required>

<label>Account Type</label>

<select name="role">

<option value="USER">User</option>

<option value="ADMIN">Administrator</option>

</select>

<button type="submit">

Create Account →

</button>

</form>

<div class="bottom">

Already have an account?

<a href="login.jsp">

Sign In

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