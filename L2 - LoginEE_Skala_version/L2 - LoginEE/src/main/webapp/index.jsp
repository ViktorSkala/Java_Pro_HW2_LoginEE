<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>Prog Academy</title>
  </head>
  <body>
    <% String sessionLogin = (String)session.getAttribute("user_login"); %>
    <% String sessionAge = (String)session.getAttribute("user_age"); %>
    <% String login = (String)request.getAttribute("req_user_login"); %>
    <% String password = (String)request.getAttribute("req_user_password"); %>
    <% String age = (String)request.getAttribute("req_user_age"); %>
    <% Integer pasLength = (Integer)session.getAttribute("user_password_length"); %>

    <% if ((sessionLogin == null || "".equals(sessionLogin)) || (sessionAge == null || "".equals(sessionAge))) { %>
        <% if ((login == null || "".equals(login)) && (password == null || "".equals(password)) && (age == null || "".equals(age))) { %>
            <form action="/login" method="POST">
            Login: <input type="text" name="login"><br>
            Password: <input type="password" name="password"><br>
            Age: <input type="text" name="age"><br>
            <input type="submit" />
            </form>
            <% } else { %>
                <% session.removeAttribute("user_login"); %>
                <% session.invalidate(); %>
                <h4> sessionLogin = <%=sessionLogin%>;</h4>
                <h3> One or several fields are empty or combination login-password is incorrect</h3>
                <form action="/login" method="POST">
                Login: <input type="text" name="login"><br>
                Password: <input type="password" name="password"><br>
                Age: <input type="text" name="age"><br>
                <input type="submit" />
                </form>
                <% } %>
        <% } else { %>
            <% if (Integer.parseInt((String)session.getAttribute("user_age")) < 18) { %>
                <% session.removeAttribute("user_login"); %>
                <% session.invalidate(); %>
                <h4> sessionLogin = <%=sessionLogin%>;</h4>
                <h3> Your age is not 18 or older</h3>
                <form   action="/login" method="POST">
                Login: <input type="text" name="login"><br>
                Password: <input type="password" name="password"><br>
                Age: <input type="text" name="age"><br>
                <input type="submit" />
                </form>
                <% } else { %>
                    <% if (pasLength < 10) { %>
                        <h3>You are logged in as: <%= sessionLogin %></h3>
                        <h4>Your password has only <%= pasLength %> characters, we recommend change your password</h4>
                        <br>Click this link to <a href="/login?a=exit">logout</a>
                        <% } else { %>
                            <h3>You are logged in as: <%= sessionLogin %></h3>
                            <br>Click this link to <a href="/login?a=exit">logout</a>
                        <% } %>
                    <% } %>
            <% } %>
  </body>
</html>