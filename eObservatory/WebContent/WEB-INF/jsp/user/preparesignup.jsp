<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript">
	function createUser()
	{
		if ($('#txtPassword').val() != $('#txtPasswordConfirm').val())
		{
			alert('Passwords don\'t match');
			return;
		}
		
		$.ajax({
			url: rootUrl + 'user/signup',
			type: 'PUT',
			dataType: 'json',
			contentType: 'application/json',
			data: JSON.stringify({
				userId: $('#txtUserName').val(),
				password: $('#txtPassword').val(),
				firstName: $('#txtFirstName').val(),
				lastName: $('#txtLastName').val(),
				country: $('#txtCountry').val(),
				city: $('#txtCity').val(),
				company: $('#txtCompany').val(),
				email: $('#txtEmail').val(),
				website: $('#txtWebsite').val()
			}),
			success: function(result)
			{
				$('#pnlRegistration').html('<div style="padding-left: 30%; padding-right: 30%">Your account has been created successfully<br/>You may now use our services. Go to <a href="' + rootUrl + 'authentication/login">Log-In</a></div>');
			}
		});
	}
</script>
<div id="pnlRegistration">
	<h1 style="color: #009">Sign Up</h1>
	<br />
	<table>
		<tr>
			<td>
				Choose a User Name:
			</td>
			<td>
				<input id="txtUserName" type="text"	/>		
			</td>
		</tr>
		<tr>
			<td>
				Choose a Password:
			</td>
			<td>
				<input id="txtPassword" type="password" />
			</td>
		</tr>
		<tr>
			<td>
				Confirm Password:
			</td>
			<td>
				<input id="txtPasswordConfirm" type="password" />
			</td>
		</tr>
		<tr>
			<td>
				First Name:
			</td>
			<td>
				<input id="txtFirstName" type="text" />
			</td>
		</tr>
		<tr>
			<td>
				Last Name:
			</td>
			<td>
				<input id="txtLastName" type="text" />
			</td>
		</tr>
		<tr>
			<td>
				Country
			</td>
			<td>
				<input id="txtCountry" type="text" />
			</td>
		</tr>
		<tr>
			<td>
				City
			</td>
			<td>
				<input id="txtCity" type="text" />
			</td>
		</tr>
		<tr>
			<td>
				Company
			</td>
			<td>
				<input id="txtCompany" type="text" />
			</td>
		</tr>
		<tr>
			<td>
				E-Mail
			</td>
			<td>
				<input id="txtEmail" type="text" />
			</td>
		</tr>
		<tr>
			<td>
				Web Site
			</td>
			<td>
				<input id="txtWebSite" type="text" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" onclick="createUser()" value="Create User" />
				<br />
				<br />
				<a href="<c:url value="/authentication/login" />">Return to Login</a>
			</td>
		</tr>
	</table>
</div>