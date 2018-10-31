<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="template/cabecera.jsp"%>

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
			file="template/barraSuperior.jsp"%> </header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar"> <%@ include
			file="template/barraLateral.jsp"%> <!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">


			<!-- Main content -->
			<section class="content">

			<div class="row">
				<div class="col-xs-12">
					<div class="box box-primary">
						<div class="box-header">
							<h3 class="box-title">Lista de Empleados</h3>
							<button id="agregarEmpleado" type="button"
								class="btn btn-primary pull-right" onclick="agregarEmpleado();">
								<i class="fa fa-plus-circle"> Agregar Empleado</i>
							</button>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">

								<div class="col-sm-12">
									<table id="listaEmpleados"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th>N°</th>
												<th>Nombre</th>
												<th>Apellidos</th>
												<th>Rut</th>
												<th>Dirección</th>
												<th>Telefono</th>
												<th>Cargo</th>
												<th>Acción</th>

											</tr>
										</thead>

										<tbody>

											<c:forEach var="listaEmpleados" items="${listaEmpleados }"
												varStatus="loop">
												<tr>
													<c:set var="index" value="${loop.index}" />
													<c:set var="index" value="${index + 1}" />

													<td><c:out value="${index}"></c:out></td>
													<td><c:out value="${listaEmpleados.nombre}"></c:out></td>
													<td><c:out value="${listaEmpleados.apellidos}"></c:out></td>
													<td><c:out value="${listaEmpleados.rut}"></c:out></td>
													<td><c:out value="${listaEmpleados.direccion}"></c:out></td>
													<td><c:out value="${listaEmpleados.telefono}"></c:out></td>
													<td><c:out value="${listaEmpleados.cargo}"></c:out></td>
													<td><a href="#"
														onclick="editarEmpleado('${listaEmpleados.rut}');"><i
															class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
														href="#"
														onclick="eliminarEmpleado('${listaEmpleados.rut}');"><i
															class="fa fa-trash-o fa-lg" style="color: red"></i></a></td>

												</tr>
											</c:forEach>
										</tbody>

									</table>
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


			<div class="modal fade" id="modalAgregarEmpleado" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Agregar Empleado</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">


										<label class="col-sm-4 control-label">* Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreEmpleado"
												onclick="nombreVacio();"> <span
												id="errorNombreEmpleado" class="error" style="display: none">Ingrese
												el nombre del empleado</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Apellidos</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="apellidosEmpleado" onclick="apellidoVacio();"> <span
												id="errorApellidosEmpleado" class="error"
												style="display: none">Ingrese los apellidos del
												empleado</span>
										</div>


										<br> <br> <label class="col-sm-4 control-label">*
											Rut</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="rutEmpleado"
												onclick="rutVacio();"> <span id="errorRutEmpleado"
												class="error" style="display: none">Ingrese el rut
												del empleado</span> <span id="errorRutEmpleadoInvalido"
												class="error" style="display: none">El rut ingresado
												es inválido</span> <span id="errorRutEmpleadoYaExiste"
												class="error" style="display: none">El rut ingresado
												ya exite</span>


										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Fecha nacimiento</label>
										<div class="col-sm-6">
											<input type="date" class="form-control"
												id="fechaNacimientoEmpleado"
												onclick="fechaNacimientoVacia();"> <span
												id="errorFechaNacimientoEmpleado" class="error"
												style="display: none">Ingrese fecha de nacimiento del
												empleado</span> <span id="errorFechaNacimientoSup" class="error"
												style="display: none">Ingrese una fecha de nacimiento
												inferior </span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Dirección</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="direccionEmpleado" onclick="direccionVacia();">
											<span id="errorDireccionEmpleado" class="error"
												style="display: none">Ingrese dirección del empleado</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Telefono</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="telefonoEmpleado"
												onclick="telefonoVacio();"> <span
												id="errorTelefonoEmpleado" class="error"
												style="display: none">Ingrese telefono del empleado</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Cargo</label>

										<div class="col-sm-6">
											<select class="form-control" id="cargoEmpleado"
												onclick="cargoVacio();">
												<option value="-1">Seleccione cargo</option>
												<option value="1">Jefe de producción</option>
												<option value="2">Gerente</option>
											</select> <span id="errorCargoEmpleado" class="error"
												style="display: none">Debe seleccionar cargo del
												empleado</span>


										</div>
										<br> <br> <label class="col-sm-4 control-label"></label>
										<div class="col-sm-6">
											<label class="pull-right"
												style="font-weight: normal; color: red">* Campos
												obligatorios</label>
										</div>


									</div>


								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-danger pull-left"
										data-dismiss="modal">Cerrar</button>
									<button id="botonGuardar" type="button" class="btn btn-primary"
										onclick="guardarDatosEmpleado();">Agregar</button>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
			<!-- Modal editar -->


			<div class="modal fade" id="modalEditarEmpleado" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Empleado</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<div style="display: none">
											<input id="rutEmpleadoEditar" />
										</div>

										<label class="col-sm-4 control-label">* Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="nombreEmpleadoEditar"> <span
												id="errorNombreEmpleadoEditar" class="error"
												style="display: none">Ingrese el nombre del empleado</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Apellidos</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="apellidosEmpleadoEditar"> <span
												id="errorApellidosEmpleadoEditar" class="error"
												style="display: none">Ingrese los apellidos del
												empleado</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Rut</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="rutEditar"
												disabled>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Fecha nacimiento</label>
										<div class="col-sm-6">
											<input type="date" class="form-control"
												id="fechaNacimientoEmpleadoEditar"> <span
												id="errorFechaNacimientoEmpleadoEditar" class="error"
												style="display: none">Ingrese fecha de nacimiento del
												empleado</span> <span id="errorFechaNacimientoSuperiorEditar"
												class="error" style="display: none">Ingrese una fecha
												de nacimiento inferior </span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Dirección</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="direccionEmpleadoEditar"> <span
												id="errorDireccionEmpleadoEditar" class="error"
												style="display: none">Ingrese dirección del empleado</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Teléfono</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="telefonoEmpleadoEditar"> <span
												id="errorTelefonoEmpleadoEditar" class="error"
												style="display: none">Ingrese teléfono del empleado</span>
										</div>


										<br> <br> <label class="col-sm-4 control-label">*
											Cargo</label>
										<div class="col-sm-6">
											<select class="form-control" id="cargoEmpleadoEditar">
											</select> <span id="errorCargoEmpleadoEditar" class="error"
												style="display: none">Debe seleccionar cargo del
												empleado</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label"></label>
										<div class="col-sm-6">
											<label class="pull-right"
												style="font-weight: normal; color: red">* Campos
												obligatorios</label>
										</div>


									</div>


								</div>


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
								<button id="botonGuardar" type="button" class="btn btn-primary"
									onclick="guardarDatosEmpleadoEditar();">Actualizar</button>
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
			file="template/pieDePagina.jsp"%> </footer>

		<div class="control-sidebar-bg"></div>

	</div>
	<%@ include file="template/scripts.jsp"%>
</body>
<script src="assets/rut.js"></script>
<script src="js/listarEmpleados.js">
	
</script>

</html>