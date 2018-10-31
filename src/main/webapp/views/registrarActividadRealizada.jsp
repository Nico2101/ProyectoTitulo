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
							<h3 class="box-title">Registrar Actividad Realizada</h3>

							<label class="pull-right" style="font-weight: normal; color: red">*
								Campos obligatorios</label>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div id="filtros" class="row">
								<div class="form-group">

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Sector</label> <select id="sector"
											class="form-control select2 select2-hidden-accessible"
											onchange="buscarPrediosSector();">

											<option value="-1">Seleccione un sector</option>
											<c:forEach var="listaSectores" items="${listaSectores}">

												<option value="${listaSectores.idSector}">${listaSectores.nombre}</option>

											</c:forEach>


										</select> <span id="errorSector" class="error" style="display: none">Seleccione
											un sector</span> <span id="sinPredio" class="error"
											style="display: none">Sector no tiene predios con
											planes asignados o todos sus predios están cosechados</span>
									</div>

									<div class="col-md-3 col-sm-6 col-xs-12" id="divPredio"
										style="display: none">
										<label>* Predio</label> <select id="predio"
											class="form-control select2 select2-hidden-accessible"
											onchange="mostrarActividades();">

										</select> <span id="errorPredio" class="error" style="display: none">Seleccione
											un predio</span>
									</div>

									<div class="col-md-3" id="divPlanAsignado"
										style="display: none">
										<label>Plan Asignado al Predio</label> <input
											id="planAsignado"
											class="form-control select2 select2-hidden-accessible"
											disabled />


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

			<div id="divTablaRegistrarActividadRealizada" style="display: none">

				<div class="row">
					<div class="col-xs-12">
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">Actividades del Plan Asignado al
									Predio</h3>

							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<div class="row">
									<div class="col-sm-3"></div>

									<div class="col-sm-12">

										<table id="tablaActividades"
											class="table table-striped table-bordered table-hover">

											<thead>
												<tr>

													<th>N°</th>
													<th width="400px">Nombre Actividad</th>
													<th>Fecha Estimada</th>
													<th>Fecha Ejecución Real</th>
													<th>Cantidad Cosechada</th>
													<th>Insumos Utilizados</th>
													<th>id actividad</th>

												</tr>
											</thead>

										</table>

									</div>
									<div class="col-sm-3"></div>

								</div>
								<br>

								<button id="botonGuardar" type="button"
									class="btn btn-primary pull-right" onclick="guardarDatos();">
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

			</div>

			<!-- Modal Agregar Insumo -->
			<div class="modal fade" id="modalAgregarInsumo" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Asignar Insumo</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-2 control-label">* Insumo</label>
										<div class="col-sm-6">
											<select id="insumo"
												class="form-control select2 select2-hidden-accessible"
												onchange="getUMInsumo();">

											</select> <span id="errorInsumo" class="error" style="display: none">Seleccione
												un insumo</span>
										</div>

										<div class="col-sm-2">
											<button class="btn btn-primary"
												onclick="abrirModalAgregarInsumoBD();">Agregar
												Insumo</button>
										</div>

										<div id="divUMInsumo" style="display: none">
											<br> <br> <label class="col-sm-2 control-label">Unidad
												de Medida</label>
											<div class="col-sm-6">
												<input type="text" class="form-control" id="umInsumo"
													disabled>
											</div>
										</div>

										<br> <br> <label class="col-sm-2 control-label">*
											Cantidad</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="cantidadInsumo"
												onkeypress="return filterFloat(event,this);"> <span
												id="errorCantidadInsumo" class="error" style="display: none">Ingrese
												la cantidad de insumo utilizado</span> <span id="errorCantidadCero"
												class="error" style="display: none">La cantidad no
												puede ser 0</span>
										</div>


										<br> <br> <label class="col-sm-2 control-label">*
											Costo</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="costoInsumo"
												onkeypress="return filterFloat(event,this);"> <span
												id="errorCostoInsumo" class="error" style="display: none">Ingrese
												el costo del insumo utilizado</span> <span id="errorCostoCero"
												class="error" style="display: none">El costo no puede
												ser 0</span>
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
									onclick="agregarInsumoAActividadRealizada();">Agregar</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal Ver Insumos Utilizados -->
			<div class="modal fade" id="modalVerInsumos" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog  modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title">Insumos utilizados en la Actividad</h4>

						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<table id="listaInsumos"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th width="25px">N°</th>
												<th>Nombre Insumo</th>
												<th>Tipo</th>
												<th>Unidad de Medida</th>
												<th>Marca</th>
												<th>Cantidad</th>
												<th>Costo</th>
												<th>Acción</th>


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



			<!-- Modal Ver Insumos Utilizados -->
			<div class="modal fade" id="modalVerInsumosDespuesDeGuardar"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true">
				<div class="modal-dialog  modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title">Insumos utilizados en la Actividad</h4>

						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<table id="listaInsumosDespuesDeGuardar"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th width="25px">N°</th>
												<th>Nombre Insumo</th>
												<th>Tipo</th>
												<th>Unidad de Medida</th>
												<th>Marca</th>
												<th>Cantidad</th>
												<th>Costo</th>



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


			<!-- Modal Editar insumo utilizado -->
			<div class="modal fade" id="modalEditarInsumo" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Insumo
								Utilizado en la Actividad</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label">Insumo</label>
										<div class="col-sm-6">
											<input id="insumoEditar" class="form-control" disabled />
										</div>


										<br> <br> <label class="col-sm-4 control-label">Unidad
											de Medida</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="umInsumoEditar"
												disabled>
										</div>


										<br> <br> <label class="col-sm-4 control-label">*
											Cantidad</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="cantidadInsumoEditar"> <span
												id="errorCantidadInsumoEditar" class="error"
												style="display: none">Ingrese la cantidad de insumo
												utilizado</span> <span id="errorCantidadCeroEditar" class="error"
												style="display: none">La cantidad no puede ser 0</span>
										</div>


										<br> <br> <label class="col-sm-4 control-label">*
											Costo</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="costoInsumoEditar"> <span
												id="errorCostoInsumoEditar" class="error"
												style="display: none">Ingrese el costo del insumo
												utilizado</span> <span id="errorCostoCeroEditar" class="error"
												style="display: none">El costo no puede ser 0</span>
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
									onclick="guardarInsumoEditado();">Actualizar</button>
							</div>
						</div>
					</div>
				</div>
			</div>


			<!-- Modal agregar insumo bd -->
			<div class="modal fade" id="modalAgregarInsumoBD" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Agregar Insumo</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label">* Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreInsumo">
											<span id="errorNombre" class="error" style="display: none">Ingrese
												el nombre del insumo</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">*
											Tipo</label>
										<div class="col-sm-6">
											<select class="form-control" id="tipoInsumo">
												<option value="-1">Seleccione Tipo</option>
												<option value="1">Combustible</option>
												<option value="2">Semilla</option>
												<option value="3">Abono</option>
												<option value="4">Fertilizante</option>
												<option value="5">Herbicida</option>

											</select> <span id="errorTipo" class="error" style="display: none">Seleccione
												el tipo de insumo</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Unidad de Medida</label>

										<div class="col-sm-6">
											<select class="form-control" id="umInsumoBD">
												<option value="-1">Seleccione Unidad de Medida</option>
												<option value="1">Kilogramo</option>
												<option value="2">Litro</option>
												<option value="3">Unidad</option>

											</select> <span id="errorUM" class="error" style="display: none">Seleccione
												la unidad de medida</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">&nbsp;&nbsp;&nbsp;Marca</label>

										<div class="col-sm-6">
											<input type="text" class="form-control" id="marcaInsumo">
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
									onclick="guardarDatosInsumo();">Agregar</button>
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

<script src="js/registrarActividadRealizada.js">
	
</script>

</html>