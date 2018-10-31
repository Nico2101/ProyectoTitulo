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
							<h3 class="box-title">Lista de Predios</h3>
							<button id="agregarPredio" type="button"
								class="btn btn-primary pull-right" onclick="agregarPredio();">
								<i class="fa fa-plus-circle"> Agregar Predio</i>
							</button>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">

								<div class="col-sm-12">
									<table id="listaPredios"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th>N°</th>
												<th>Nombre</th>
												<th>Superficie</th>
												<th>Sector</th>
												<th>Acción</th>

											</tr>
										</thead>

										<tbody>

											<c:forEach var="predios" items="${listaPredios }"
												varStatus="loop">
												<tr>
													<c:set var="index" value="${loop.index}" />
													<c:set var="index" value="${index + 1}" />

													<td><c:out value="${index}"></c:out></td>
													<td><c:out value="${predios.nombre}"></c:out></td>
													<td><c:out value="${predios.superficie}"></c:out></td>
													<td><c:out value="${predios.sector.nombre}"></c:out></td>
													<td><a href="#"
														onclick="editarPredio(${predios.idPredio});"><i
															class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
														href="#" onclick="eliminarPredio(${predios.idPredio});"><i
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


			<div class="modal fade" id="modalAgregarPredio" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Agregar Predio</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label">* Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombrePredio"
												onclick="nombrePredioVacio();"> <span
												id="errorNombre" class="error" style="display: none">Ingrese
												el nombre del predio</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Sector </label>
										<div class="col-sm-6">
											<select class="form-control" id="sectorSeleccionado"
												onchange="superficieTotalPredios()"
												onclick="sectorNoSeleccionado();">
												<option value="-1">Seleccione sector al que
													pertenece</option>
												<c:forEach items="${sectores}" var="sectores">
													<option value="${sectores.idSector}"><c:out
															value="${sectores.nombre}" /></option>

												</c:forEach>

											</select> <span id="errorSector" class="error" style="display: none">Seleccione
												el sector</span>

										</div>
										<div id="mostrar" style="display: none">
											<br> <br> <label class="col-sm-4 control-label">Superficie
												total sector(m<sup>2</sup>)
											</label>
											<div class="col-sm-6">
												<input type="number" class="form-control" id="idinput1"
													disabled>

											</div>

											<br> <br> <label class="col-sm-4 control-label">Superficie
												ocupada (m<sup>2</sup>)
											</label>
											<div class="col-sm-6">
												<input type="number" class="form-control" id="idinput2"
													disabled>


											</div>

											<br> <br> <label class="col-sm-4 control-label">Superficie
												disponible (m<sup>2</sup>)
											</label>
											<div class="col-sm-6">
												<input type="number" class="form-control" id="idinput3"
													disabled>


											</div>

											<br> <br> <label class="col-sm-4 control-label">*
												Superficie predio (m<sup>2</sup>)
											</label>
											<div class="col-sm-6">
												<input type="number" class="form-control"
													onkeypress="return filterFloat(event,this);"
													id="superficiePredio" onclick="superficiePredioVacia();">
												<span id="errorSuperficie" class="error"
													style="display: none">Ingrese la superficie del
													predio</span> <span id="errorSubTotal" class="error"
													style="display: none">La superficie ingresada debe
													ser menor</span> <span id="errorSuperficieNegativa" class="error"
													style="display: none">La superficie no puede ser
													negativa</span> <span id="errorSuperficieNoPuedeSerCero"
													class="error" style="display: none">La superficie no
													puede ser cero</span>
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


							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger pull-left"
									data-dismiss="modal">Cerrar</button>
								<button id="botonGuardar" type="button" class="btn btn-primary"
									onclick="guardarDatosPredio();">Agregar</button>
							</div>
						</div>
					</div>
				</div>
			</div>


			<!-- Modal editar -->


			<div class="modal fade" id="modalEditarPredio" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Predio</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<div style="display: none">
											<input id="idPredioEditar" />
										</div>

										<label class="col-sm-4 control-label">* Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="nombrePredioEditar"> <span
												id="errorNombreEditar" class="error" style="display: none">Ingrese
												el nombre del predio</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">*
											Sector</label>
										<div class="col-sm-6">
											<select class="form-control" id="sectorEditar"
												onchange="superficieTotalPrediosEditar();">
											</select> <span id="errorSectorEditar" class="error"
												style="display: none">Seleccione el sector</span>
										</div>


										<br> <br> <label class="col-sm-4 control-label">Superficie
											total sector(m<sup>2</sup>)
										</label>
										<div class="col-sm-6">
											<input type="number" class="form-control" id="totalSector"
												disabled>

										</div>

										<br> <br> <label class="col-sm-4 control-label">Superficie
											ocupada(m<sup>2</sup>)
										</label>
										<div class="col-sm-6">
											<input type="number" class="form-control" id="totalPredios"
												disabled>

										</div>

										<br> <br> <label class="col-sm-4 control-label">Superficie
											disponible (m<sup>2</sup>)
										</label>
										<div class="col-sm-6">
											<input type="number" class="form-control"
												id="superficieDisponible" disabled>

										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Superficie (m<sup>2</sup>)
										</label>
										<div class="col-sm-6">
											<input type="number" class="form-control"
												onkeypress="return filterFloat(event,this);"
												id="superficieEditar"> <span
												id="errorSuperficieEditar" class="error"
												style="display: none">Ingrese la superficie del
												predio</span> <span id="errorSubTotalEditar" class="error"
												style="display: none">La superficie ingresada debe
												ser menor</span> <span id="errorSuperficieNegativaEditar"
												class="error" style="display: none">La superficie no
												puede ser negativa</span> <span
												id="errorSuperficieNoPuedeSerCeroEditar" class="error"
												style="display: none">La superficie no puede ser cero</span>
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
									onclick="guardarDatosPredioEditar();">Actualizar</button>
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

<script src="js/listarPredios.js">



</script>

</html>