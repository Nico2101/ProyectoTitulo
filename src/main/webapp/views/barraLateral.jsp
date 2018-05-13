<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="libreria.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<section class="sidebar"> <!-- sidebar menu: : style can be found in sidebar.less -->
<ul class="sidebar-menu" data-widget="tree">
	<li class=""><a href="index"> <i class="fa fa-home"></i> <span>Inicio</span>
			<span class="pull-right-container"> </span>
	</a></li>




	<li class="treeview"><a href="#"> <i class="fa fa-list-alt"></i>
			<span><c:out value="Plan de Ejecución"></c:out></span> <i
			class="fa fa-angle-left pull-right"></i>

	</a>
		<ul class="treeview-menu">


			<li><a href="agregarPlan"> <i class="fa fa-circle-o"></i> <span><c:out
							value="Agregar Plan"></c:out></span>

			</a></li>

			<li><a href="#"> <i class="fa fa-circle-o"></i> <span><c:out
							value="Agregar actividad a plan"></c:out></span>

			</a></li>

			<li><a href="listarPlanes"> <i class="fa fa-circle-o"></i> <span><c:out
							value="Ver Planes"></c:out></span>

			</a></li>


		</ul></li>

	<li><a href="#"> <i class="fa fa-edit"></i> <span><c:out
					value="Registrar Actividad"></c:out></span>

	</a></li>



	<li class="treeview"><a href="#"> <i class="fa fa-info-circle"></i>
			<span><c:out value="Insumos"></c:out></span> <i
			class="fa fa-angle-left pull-right"></i>

	</a>
		<ul class="treeview-menu">
			<li><a href="ListarInsumos"> <i class="fa fa-circle-o"></i>
					<span><c:out value="Listar Insumos"></c:out></span>

			</a></li>


		</ul></li>



	<li class="treeview"><a href="#"> <i class="fa fa-map-o"></i>
			<span><c:out value="Sectores y Predios"></c:out></span> <i
			class="fa fa-angle-left pull-right"></i>

	</a>
		<ul class="treeview-menu">

			<li><a href="listaSectores"> <i class="fa fa-circle-o"></i>
					<span><c:out value="Listar Sectores"></c:out></span>

			</a></li>

			<li><a href="ListarPredios"> <i class="fa fa-circle-o"></i> <span><c:out
							value="Listar Predios"></c:out></span>

			</a></li>
		</ul></li>


	<li class="treeview"><a href="#"> <i class="fa fa-clock-o"></i>
			<span><c:out value="Gestión de Temporadas"></c:out></span> <i
			class="fa fa-angle-left pull-right"></i>

	</a>
		<ul class="treeview-menu">

			<li><a href="ListaTemporadas"> <i class="fa fa-circle-o"></i>
					<span><c:out value="Listar Temporadas"></c:out></span>

			</a></li>

		</ul></li>


<li class="treeview"><a href="#"> <i class="fa fa-user"></i>
			<span><c:out value="Gestión de usuarios"></c:out></span> <i
			class="fa fa-angle-left pull-right"></i>

	</a>
		<ul class="treeview-menu">

			<li><a href="ListarEmpleados"> <i class="fa fa-circle-o"></i>
					<span><c:out value="Listar empleados"></c:out></span>

			</a></li>

		</ul></li>




	<li class="treeview"><a href="#"> <i class="fa fa-file-pdf-o"></i>
			<span><c:out value="Reportes"></c:out></span> <i
			class="fa fa-angle-left pull-right"></i>

	</a>
		<ul class="treeview-menu">


			<li><a href="#"> <i class="fa fa-circle-o"></i> <span><c:out
							value="Rendimiento por Sector"></c:out></span>

			</a></li>

			<li><a href="#"> <i class="fa fa-circle-o"></i> <span><c:out
							value="Rendimiento por producto"></c:out></span>

			</a></li>
		</ul></li>





</ul>
</section>