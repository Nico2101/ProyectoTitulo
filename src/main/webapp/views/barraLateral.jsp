<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="libreria.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<section class="sidebar"> <!-- sidebar menu: : style can be found in sidebar.less -->
<ul class="sidebar-menu" data-widget="tree">
	<li class=""><a href="index"> <i class="fa fa-home"></i> <span>Inicio</span>
			<span class="pull-right-container"> </span>
	</a></li>


	<c:forEach var="menuConSubmenu" items="${menuConSubmenu}">

		<li class="treeview"><a href="#"> <i
				class="${menuConSubmenu.icono }"></i> <span><c:out
						value="${menuConSubmenu.nombre}"></c:out></span> <i
				class="fa fa-angle-left pull-right"></i>


		</a>
			<ul class="treeview-menu">
				<c:forEach var="submenu" items="${submenu}">
					<c:if test="${menuConSubmenu.idMenu==submenu.menu.idMenu }">
						<li><a href="${submenu.nombre}"> <i
								class="fa fa-circle-o"></i> <span><c:out
										value="${submenu.nombre}"></c:out></span>

						</a></li>

					</c:if>
				</c:forEach>
			</ul></li>

	</c:forEach>

	<c:forEach var="menuSinSubmenu" items="${menuSinSubmenu}">

		<li><a href="${menuSinSubmenu.nombre}"> <i
				class="${menuSinSubmenu.icono }"></i> <span><c:out
						value="${menuSinSubmenu.nombre }"></c:out></span>

		</a></li>

	</c:forEach>


</ul>
</section>