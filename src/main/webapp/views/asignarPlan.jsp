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
							<h3 class="box-title">Asignar Plan a Predio</h3>

							<label class="pull-right" style="font-weight: normal; color: red">*
								Campos obligatorios</label>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div id="filtros" class="row">
								<div class="form-group">

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Sector</label><select class="form-control"
											id="sectorSeleccionado" onchange="PrediosDeunSector()">
											<option value="-1">Seleccione sector</option>
											<c:forEach items="${sectores}" var="sectores">
												<option value="${sectores.idSector}"><c:out
														value="${sectores.nombre}" /></option>

											</c:forEach>

										</select> <span id="errorSector" class="error" style="display: none">Debe
											seleccionar un sector</span> <span id="sinPredio" class="error"
											style="display: none">Sector no tiene predios
											disponibles</span>
									</div>






									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Predio</label><select class="form-control"
											id="predioSeleccionado">
											<option value="-1">Seleccione un predio</option>


										</select> <span id="errorPredio" class="error" style="display: none">Debe
											seleccionar un predio</span>
									</div>

									<div class="col-md-3 col-sm-6 col-xs-12">
										<label>* Temporada</label><select class="form-control"
											id="temporadaSeleccionada" onchange="mostrarPlanes();">
											<option value="-1">Seleccione temporada</option>
											<c:forEach items="${listaTemporadasActivas}"
												var="listaTemporadasActivas">
												<option value="${listaTemporadasActivas.idTemporada}"><c:out
														value="${listaTemporadasActivas.nombre}" /></option>

											</c:forEach>

										</select> <span id="errorTemporada" class="error" style="display: none">Debe
											seleccionar una temporada</span>
									</div>

									<div class="col-md-3 col-sm-4 col-xs-12" id="divPlanes"
										style="display: none">
										<label>* Plan</label><select class="form-control"
											id="planSeleccionado" onchange="actividadesDeUnPlan()">
											<option value="-1">Seleccione un plan</option>
											<c:forEach items="${listaPlanes}" var="listaPlanes">
												<option value="${listaPlanes.idPlanEjecucion}"><c:out
														value="${listaPlanes.nombre}" /></option>

											</c:forEach>

										</select> <span id="errorPlan" class="error" style="display: none">Debe
											seleccionar un plan</span>
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
			<div id="divTablaActividades" style="display: none">
				<div class="row">
					<div class="col-xs-12">
						<div class="box box-primary">

							<!-- /.box-header -->
							<div class="box-body">
								<h4 class="box-title">
									<center>
										<strong>Actividades del plan</strong>
									</center>
								</h4>

								<p>
									Las fechas estimadas ingresadas deben estar dentro de la
									duración de la temporada a partir de la fecha actual, las
									cuales corresponden : Fecha Inicio : <label id="fechaInicio">
									</label> y Fecha Término : <label id="fechaTermino"> </label>
								</p>


								<div class="row">
									<div class="col-sm-2" style="text-align: center;"></div>

									<div class="col-sm-7">
										<table id="tablaActividades"
											class="table table-striped table-bordered table-hover">

											<thead>
												<tr>

													<th width="50px">N°</th>
													<th width="260px">Nombre Actividad</th>
													<th width="200px">Fecha estimada de realización</th>
													<th><center>Id</center></th>


												</tr>
											</thead>
											<tbody id="contenido">

											</tbody>
										</table>

									</div>
									<div class="col-sm-3"></div>

								</div>
								<br>

								<div id="loader" class="pull-right" style="display: none">
									<img id="imagen" src="images/loaderWhite.gif" height="30"
										width="30" />
								</div>

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

<script src="js/asignarPlan.js">
	
</script>

</html>