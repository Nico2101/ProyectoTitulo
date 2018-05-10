<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="libreria.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="cabecera.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<style>
.error {
	color: #FF0000;
}
</style>

</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">

		<header class="main-header"> <%@ include
			file="barraSuperior.jsp"%> </header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar"> <%@ include
			file="barraLateral.jsp"%> <!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">


			<!-- Main content -->
			<section class="content">

			<div class="row">
				<div class="col-xs-12">
					<div class="box box-primary">
						<div class="box-header">
							<h3 class="box-title">Plan de Ejecución</h3>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div id="filtros" class="row">
								<div class="form-group">

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>Nombre del Plan</label><input id="nombrePlan"
											name="numeroOC" type="text"
											class="form-control select2 select2-hidden-accessible"
											onclick="javascript: limpia(this);" />
											<span id="errorNombrePlan" class="error"
												style="display: none">Ingrese el nombre del plan</span>
									</div>

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>Fecha de Creación</label> <input id="fechaCreacion"
											type="date"
											class="form-control select2 select2-hidden-accessible"
											name="daterange" value="" />
											
											<span id="errorFechaCreacion" class="error"
												style="display: none">Ingrese la fecha de creación</span>
									</div>


								</div>
							</div>
							<br>

						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->


					<!-- /.box -->
				</div>
				<!-- /.col -->
			</div>


			<!-- Actividades -->
			<div class="row">
				<div class="col-xs-12">
					<div class="box box-primary">
						<div class="box-header">
							<h3 class="box-title">Actividades del Plan</h3>
							<button id="agregarActividad" type="button"
								class="btn btn-primary pull-right"
								onclick="modalAgregarActividad();">
								<i class="fa fa-plus-circle"> Agregar Actividad</i>
							</button>
						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">
								<div class="col-sm-3"></div>

								<div class="col-sm-6">
									<table id="tablaActiviades"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>

												<th>N°</th>
												<th>Nombre Actividad</th>
												<th>Acción</th>

											</tr>
										</thead>

									</table>

								</div>
								<div class="col-sm-3"></div>

							</div>
							<br>

							<button type="button" class="btn btn-primary pull-right"
								onclick="guardarDatos();">
								<i class="fa fa-save"> Guardar</i>
							</button>

						</div>
						<!-- /.box-body -->
					</div>
					<!-- /.box -->


					<!-- /.box -->
				</div>
				<!-- /.col -->
			</div>

			<!-- Modal Agregar Activiad -->
			<div class="modal fade" id="modalAgregarActividad" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Agregar Actividad</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label">Nombre Actividad</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreActividad">
											<span id="errorNombreActividad" class="error"
												style="display: none">Ingrese el nombre de la
												actividad</span>
										</div>

									</div>


								</div>


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
								<button id="botonGuardar" type="button" class="btn btn-primary"
									onclick="guardarDatosActividad();">Agregar</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			</section>

		</div>

		<!-- /.content-wrapper -->

		<footer align="center" class="main-footer"
			style="background-color:#ecf0f5;"> <%@ include
			file="pieDePagina.jsp"%> </footer>

		<div class="control-sidebar-bg"></div>

	</div>
	<%@ include file="scripts.jsp"%>
</body>

<script>
	function modalAgregarActividad() {
		$('#nombreActividad').val("");
		$('#modalAgregarActividad').modal('show');
	}

	function guardarDatos() {

		//Obtener los datos del plan
		var nombrePlan = $('#nombrePlan').val();
		var fechaCreacion = $('#fechaCreacion').val();

		if (nombrePlan == "") {
			document.getElementById('errorNombrePlan').style.display = 'inline';
			document.getElementById('nombrePlan').style.border = "1px solid red";
		} else {
			document.getElementById('errorNombrePlan').style.display = 'none';
			document.getElementById('nombrePlan').style.border = "";
		}
		
		if (fechaCreacion == "") {
			document.getElementById('errorFechaCreacion').style.display = 'inline';
			document.getElementById('fechaCreacion').style.border = "1px solid red";
		} else {
			document.getElementById('errorFechaCreacion').style.display = 'none';
			document.getElementById('fechaCreacion').style.border = "";
		}
	}
</script>

</html>