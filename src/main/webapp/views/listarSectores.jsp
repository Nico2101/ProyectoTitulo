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
							<h3 class="box-title">Lista de Sectores</h3>

							<button class="btn btn-primary pull-right" id="AgregarSector"
								type="button" onclick="agregarSector();">
								<i class="fa fa-plus-circle"> Agregar Sector</i>
							</button>

						</div>

						<div class="box-body">
							<div class="row">
								<div class="col-xs-12">
									<table id="listaSectores"
										class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Nº</th>
												<th>Nombre</th>
												<th>Superficie (m<sup>2</sup>)
												</th>
												<th>Acción</th>

											</tr>
										</thead>
										<c:set var="i" value="0" />
										<c:forEach var="sectores" items="${sectores}">
											<c:set var="i" value="${i+1}" />
											<tr>


												<td><c:out value="${i}"></c:out></td>
												<td><c:out value="${sectores.nombre}"></c:out></td>
												<td><c:out value="${sectores.superficie}"></c:out></td>
												<td><a href="#"
													onclick="editarSector(${sectores.idSector});"><i
														class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
													href="#" onclick="eliminarSector(${sectores.idSector});"><i
														class="fa fa-trash-o fa-lg" style="color: red"></i></a></td>


											</tr>
										</c:forEach>

									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>




			<!-- Modal -->

			<div class="modal fade" id="modalAgregarSector" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Agregar Sector</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<label class="col-sm-4 control-label">* Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreSector"
												onclick="sectorVacio();"> <span id="errorNombre"
												class="error" style="display: none">Ingrese el nombre
												del sector</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">*
											Superficie (m<sup>2</sup>)
										</label>

										<div class="col-sm-6">
											<input type="text" class="form-control" id="superficieSector"
												onkeypress="return filterFloat(event,this);"
												onclick="superficieVacia();"> <span
												id="errorSuperficie" class="error" style="display: none">Ingrese
												la superficie del sector</span> <span id="errorSuperficieNegativa"
												class="error" style="display: none">La superficie no
												puede ser negativa</span>
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
									onclick="guardarDatosSector();">Agregar</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- Modal editar -->


			<div class="modal fade" id="modalEditarSector" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Sector</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<div style="display: none">
											<input id="idSectorEditar" />
										</div>

										<label class="col-sm-4 control-label">* Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="nombreSectorEditar"> <span
												id="errorNombreEditar" class="error" style="display: none">Ingrese
												el nombre del sector</span>

										</div>
										<br> <br> <label class="col-sm-4 control-label">*
											Superficie (m<sup>2</sup>)
										</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												onkeypress="return filterFloat(event,this);"
												id="superficieSectorEditar"> <span
												id="errorSuperficieEditar" class="error"
												style="display: none">Ingrese la superficie del
												sector</span> <span id="errorSuperficieNegativaEditar"
												class="error" style="display: none">La superficie no
												puede ser negativa</span>

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
										onclick="guardarDatosSectorEditar();">Actualizar</button>
								</div>
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

<script src="js/listarSectores.js">


</script>
</html>