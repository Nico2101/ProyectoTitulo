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
							<h3 class="box-title">Mostrar estado de los predios</h3>

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
											onchange="mostrarEstadoPredios();">

											<option value="-1">Seleccione un sector</option>
											<c:forEach var="listaSectores" items="${listaSectores}">

												<option value="${listaSectores.idSector}">${listaSectores.nombre}</option>

											</c:forEach>


										</select> <span id="errorSector" class="error" style="display: none">Seleccione
											un sector</span> <span id="sinPredio" class="error"
											style="display: none">Sector no tiene predios</span>
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

			<div id="divTablaEstadoPredios" style="display: none">

				<div class="row">
					<div class="col-xs-12">
						<div class="box box-primary">
							<div class="box-header">
								<h3 class="box-title">Lista de predios</h3>

							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<div class="row">
									<div class="col-sm-2" style="text-align: center;"></div>

									<div class="col-sm-7">
										<table id="tablaEstadoPredios"
											class="table table-striped table-bordered table-hover">

											<thead>
												<tr>

													<th>N°</th>
													<th width="400px">Nombre Predio</th>
													<th width="250px">Estado</th>
													<th width="250px">Plan Ejecución</th>
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

<script src="js/mostrarEstadoPredios.js">
	
</script>

</html>