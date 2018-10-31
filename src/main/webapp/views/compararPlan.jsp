<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="template/libreria.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="template/cabecera.jsp"%>
<style>
.error {
	color: #FF0000;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

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
							<h3 class="box-title">Seguimiento Planes</h3>

							<label class="pull-right" style="font-weight: normal; color: red">*
								Campos obligatorios</label>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div id="filtros" class="row">
								<div class="form-group">

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Temporada</label> <select id="temporada"
											class="form-control select2 select2-hidden-accessible"
											onchange="buscarSector();">

											<option value="-1">Seleccione una temporada</option>
											<c:forEach var="listaTemporadas" items="${listaTemporadas}">

												<option value="${listaTemporadas.idTemporada}">${listaTemporadas.nombre}</option>

											</c:forEach>


										</select> <span id="errorTemporada" class="error" style="display: none">Seleccione
											una temporada</span> <span id="errorTemporada2" class="error"
											style="display: none">Temporada no ha sido ejecutada
											en ningún predio</span>
									</div>

									<div id="divSector" class="col-md-3 col-sm-6 col-xs-12"
										style="display: none">
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
											planes asignados en la temporada</span>
									</div>

									<div class="col-md-3 col-sm-6 col-xs-12" id="divPredio"
										style="display: none">
										<label>* Predio</label> <select id="predio"
											class="form-control select2 select2-hidden-accessible"
											onchange="mostrarActividades();">

										</select> <span id="errorPredio" class="error" style="display: none">Seleccione
											un predio</span>
									</div>
									<div class="col-md-3" id="loader" style="display: none">
										<br> <img id="imagen" src="images/loaderWhite.gif"
											height="30" width="30" />
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

			<div id="divTablaActividades" style="display: none">

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
													<th width="135px">Fecha Estimada Inicial</th>
													<th width="350px">Fecha Ejecución Real</th>
													<th width="100px">Reprogramaciones</th>
													<th>id actividad</th>
													<th>Costos</th>

												</tr>
											</thead>

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

			</div>


			<!-- Modal ver reprogramaciones -->
			<div class="modal fade" id="modalVerReprogramaciones" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Reprogramaciones
								de la Actividad</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<table id="tablaReprogramaciones"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>

												<th width="40px">N°</th>
												<th>Nombre Actividad</th>
												<th width="170px">Fecha Estimada Anterior</th>
												<th width="170px">Fecha Reprogramación</th>
												<th>Motivo</th>

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


			<!-- Modal Ver Detalle de costos -->
			<div class="modal fade" id="modalVerDetallesCostos" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog  modal-lg" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title">Detalle de costos</h4>

						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<table id="listaDetallesCostos"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th width="25px">N°</th>
												<th>Nombre Insumo</th>
												<th>Tipo</th>
												<th>Unidad de Medida</th>
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


<script src="js/compararPlan.js">
	
</script>

</html>