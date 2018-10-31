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
							<h3 class="box-title">Lista de Temporadas</h3>
							<button id="agregarInsumo" type="button"
								class="btn btn-primary pull-right" onclick="agregarTemporada();">
								<i class="fa fa-plus-circle"> Agregar Temporada</i>
							</button>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">

								<div class="col-sm-12">
									<table id="listaTemporadas"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th>N°</th>
												<th>Nombre</th>
												<th>Fecha de inicio</th>
												<th>Fecha de término</th>
												<th>Estado</th>
												<th></th>

											</tr>
										</thead>

										<tbody>

											<c:forEach var="listaTemporadas" items="${listaTemporadas }"
												varStatus="loop">
												<tr>
													<c:set var="index" value="${loop.index}" />
													<c:set var="index" value="${index + 1}" />

													<td><c:out value="${index}"></c:out></td>
													<td><c:out value="${listaTemporadas.nombre}"></c:out></td>
													<td><fmt:formatDate pattern="dd-MM-yyyy"
															value="${listaTemporadas.fechaInicio}" /></td>
													<td><fmt:formatDate pattern="dd-MM-yyyy"
															value="${listaTemporadas.fechaTermino}" /></td>

													<c:if test="${listaTemporadas.estado==true}">
														<td><c:out value="Temporada Activa"></c:out></td>
													</c:if>

													<c:if test="${listaTemporadas.estado!=true}">
														<td><c:out value="Temporada Finalizada"></c:out></td>
													</c:if>

													<c:if test="${listaTemporadas.estado==true}">

														<td><a href="#"
															onclick="editarTemporada(${listaTemporadas.idTemporada});"><i
																title="Editar Temporada" class="fa fa-edit fa-lg"
																style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
															href="#" title="Eliminar Temporada"
															onclick="eliminarTemporada(${listaTemporadas.idTemporada});"><i
																class="fa fa-trash-o fa-lg" style="color: red"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
															<a href="#" title="Finalizar Temporada"
															onclick="finalizarTemporada(${listaTemporadas.idTemporada});"><i
																class="fa fa-check fa-lg" style="color: green"></i></a></td>

													</c:if>

													<c:if test="${listaTemporadas.estado!=true}">

														<td></td>

													</c:if>

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


			<div class="modal fade" id="modalAgregarTemporada" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Agregar Temporada</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label">* Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreTemporada">
											<span id="errorNombreTemporada" class="error"
												style="display: none">Ingrese el nombre de la
												temporada</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">*
											Fecha de inicio</label>
										<div class="col-sm-6">
											<input type="date" class="form-control" id="fechaInicio">
											<span id="errorFechaInicio" class="error"
												style="display: none">Indique la fecha de inicio</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Fecha de término</label>

										<div class="col-sm-6">
											<input type="date" class="form-control" id="fechaTermino">
											<span id="errorFechaTermino" class="error"
												style="display: none">Indique la fecha de término</span> <span
												id="errorFechaTerminoMenor" class="error"
												style="display: none">La fecha de término debe ser
												mayor a fecha de inicio</span>
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
									onclick="guardarDatosTemporada();">Agregar</button>
							</div>
						</div>
					</div>
				</div>
			</div>


			<!-- Modal editar -->


			<div class="modal fade" id="modalEditarTemporada" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Temporada</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<div style="display: none">
											<input id="idTemporadaEditar" />
										</div>

										<label class="col-sm-4 control-label">* Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="nombreTemporadaEditar"> <span
												id="errorNombreTemporadaEditar" class="error"
												style="display: none">Ingrese el nombre de la
												temporada</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">*
											Fecha de inicio</label>
										<div class="col-sm-6">
											<input type="date" class="form-control"
												id="fechaInicioEditar"> <span
												id="errorFechaInicioEditar" class="error"
												style="display: none">Indique la fecha de inicio</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Fecha de término</label>
										<div class="col-sm-6">
											<input type="date" class="form-control"
												id="fechaTerminoEditar"> <span
												id="errorFechaTerminoEditar" class="error"
												style="display: none">Indique la fecha de término</span> <span
												id="errorFechaTerminoMenorEditar" class="error"
												style="display: none">La fecha de término debe ser
												mayor a fecha de inicio</span>
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
									onclick="guardarDatosTemporadaEditar();">Actualizar</button>
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

<script src="js/listarTemporadas.js">
	
</script>

</html>