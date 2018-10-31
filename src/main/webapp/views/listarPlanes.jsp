<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="template/libreria.jsp"%>
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
							<h3 class="box-title">Lista de Planes Genéricos</h3>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">
								<div class="col-sm-3"></div>
								<div class="col-sm-6">
									<table id="listaPlanes"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th width="25px">N°</th>
												<th>Nombre Plan</th>
												<th>Fecha Creación</th>
												<th width="90px"></th>


											</tr>
										</thead>

										<tbody>

											<c:forEach var="listaPlanes" items="${listaPlanes}"
												varStatus="loop">
												<tr>
													<c:set var="index" value="${loop.index}" />
													<c:set var="index" value="${index + 1}" />

													<td><c:out value="${index}"></c:out></td>
													<td><c:out value="${listaPlanes.nombre}"></c:out></td>
													<td><fmt:formatDate pattern="dd-MM-yyyy"
															value="${listaPlanes.fechaCreacion}" /></td>
													<td><a href="#" title="Ver"
														onclick="verPlan(${listaPlanes.idPlanEjecucion});"><i
															class="fa fa-eye fa-lg" style="color: blue"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<a href="#" title="Editar"
														onclick="editarPlan(${listaPlanes.idPlanEjecucion});"><i
															class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
														href="#" title="Eliminar"
														onclick="eliminarPlan(${listaPlanes.idPlanEjecucion});"><i
															class="fa fa-trash-o fa-lg" style="color: red"></i></a></td>

												</tr>
											</c:forEach>
										</tbody>

									</table>
								</div>
								<div class="col-sm-3"></div>
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


			</section>

			<!-- Modal Ver Plan -->

			<div class="modal fade" id="modalVerPlan" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="tituloPlan"></h4>
							<button id="agregarActividad" type="button"
								class="btn btn-primary pull-right"
								onclick="modalAgregarActividad();">
								<i class="fa fa-plus-circle"> Agregar Actividad</i>
							</button>
						</div>
						<div class="modal-body">

							<p>Nota: Para actualizar el orden de las actividades debe
								seleccionar el número y arrastrarlo a la posición que desee</p>
							<div class="row">

								<div class="box-body">

									<table id="listaActividadesPlan"
										class="table table-striped table-bordered table-hover"
										width="100%">

										<thead>
											<tr>
												<th width="25px">N°</th>
												<th>Nombre Actividad</th>
												<th width="150px"></th>
												<th width="10px"></th>

											</tr>
										</thead>
									</table>


								</div>


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
							</div>
						</div>
					</div>
				</div>
			</div>


			<!-- Modal Editar Plan -->
			<div class="modal fade" id="modalEditarPlan" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Plan</h4>

						</div>
						<div class="modal-body">


							<div id="form-editar" class="form-group">


								<label class="col-sm-4 control-label">* Nombre Plan</label>
								<div class="col-sm-6">
									<input type="text" class="form-control" id="nombrePlanEditar">
									<span id="errorNombrePlanEditar" class="error"
										style="display: none">Ingrese el nombre del plan</span>
								</div>
								<br> <br> <label class="col-sm-4 control-label">*
									Fecha Creación</label>
								<div class="col-sm-6">
									<input type="date" class="form-control"
										id="fechaCreacionEditar"> <span
										id="errorFechaCreacionEditar" class="error"
										style="display: none">Ingrese la fecha de creación del
										plan</span> <span id="errorFechaCreacionEditarMayor" class="error"
										style="display: none">La fecha no puede ser futura</span>
								</div>
								<br> <br> <br> <label
									class="col-sm-4 control-label"></label>
								<div class="col-sm-6">
									<label class="pull-right"
										style="font-weight: normal; color: red">* Campos
										obligatorios</label>
								</div>
							</div>

						</div>

						<br> <br>

						<div class="modal-footer">
							<button type="button" class="btn btn-danger pull-left"
								data-dismiss="modal">Cerrar</button>
							<button type="button" class="btn btn-primary pull-right"
								onclick="actualizarPlan();">Actualizar</button>
						</div>
					</div>
				</div>
			</div>


			<!-- Modal Editar Actividad -->
			<div class="modal fade" id="modalEditarActividad" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Actividad</h4>

						</div>
						<div class="modal-body">


							<div id="form-editar" class="form-group">


								<label class="col-sm-4 control-label">* Nombre Actividad</label>
								<div class="col-sm-6">
									<input type="text" class="form-control"
										id="nombreActividadEditar"> <span
										id="errorNombreActividadEditar" class="error"
										style="display: none">Ingrese el nombre de la actividad</span>
								</div>

								<br> <br> <br> <label
									class="col-sm-4 control-label"></label>
								<div class="col-sm-8">
									<input type="checkbox" class="" id="checkCosechaEditar">
									Seleccione sólo si la actividad corresponde a cosecha
								</div>

								<br> <br> <br> <label
									class="col-sm-4 control-label"></label>
								<div class="col-sm-6">
									<label class="pull-right"
										style="font-weight: normal; color: red">* Campos
										obligatorios</label>
								</div>

							</div>

						</div>
						<br> <br>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger pull-left"
								data-dismiss="modal">Cerrar</button>
							<button type="button" class="btn btn-primary pull-right"
								onclick="actualizarActividadPlan();">Actualizar</button>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal Agregar Actividad -->
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

										<label class="col-sm-4 control-label"
											id="tituloActividadAgregar">*Nombre Actividad</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreActividad">
											<span id="errorNombreActividad" class="error"
												style="display: none">Ingrese el nombre de la
												actividad</span>
										</div>

										<br> <br> <br> <label
											class="col-sm-4 control-label"></label>
										<div class="col-sm-8">
											<input type="checkbox" class="" id="checkCosecha">
											Seleccione sólo si la actividad corresponde a cosecha
										</div>

										<br> <br> <br> <label
											class="col-sm-4 control-label"></label>
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
									onclick="agregarActividad();">Agregar</button>
							</div>
						</div>
					</div>
				</div>
			</div>



		</div>

		<!-- /.content-wrapper -->

		<footer align="center" class="main-footer"
			style="background-color:#ecf0f5;"> <%@ include
			file="template/pieDePagina.jsp"%> </footer>

		<div class="control-sidebar-bg"></div>

	</div>
	<%@ include file="template/scripts.jsp"%>
</body>

<script src="js/listarPlanes.js">


</script>

</html>