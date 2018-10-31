<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="libreria.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Logo -->
<a href="index" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
	<span class="logo-mini"><i class="glyphicon glyphicon-grain"></i></span> <!-- logo for regular state and mobile devices -->
	<span class="logo-lg"><i class="glyphicon glyphicon-grain"></i>Fundo Santa Emilia</span>
</a>
<!-- Header Navbar: style can be found in header.less -->
<nav class="navbar navbar-static-top"> <!-- Sidebar toggle button-->
<a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
	<span class="sr-only">Toggle navigation</span>
</a>

<div class="navbar-custom-menu">
	<ul class="nav navbar-nav">


		<!-- User Account: style can be found in dropdown.less -->
		<li class="dropdown user user-menu"><a href="#"
			class="dropdown-toggle" data-toggle="dropdown"> <img
				src="images/user.png" class="user-image"
				alt="User Image"> <span class="hidden-xs">Bienvenido(a) ${empleado.nombre }</span>
		</a>
			<ul class="dropdown-menu">
				<!-- User image -->
				<li class="user-header"><img
					src="images/user.png" class="img-circle"
					alt="User Image">

					<p>
						${empleado.nombre} - ${empleado.cargo} <small></small>
					</p></li>

				<!-- Menu Footer-->
				<li class="user-footer">

					<div align="center">
						<a href="logout" class="btn btn-default">Cerrar Sesión</a>
					</div>
				</li>
			</ul></li>
		<!-- Control Sidebar Toggle Button -->

	</ul>
</div>
</nav>