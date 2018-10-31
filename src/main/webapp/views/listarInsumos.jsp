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
							<h3 class="box-title">Lista de Insumos</h3>
							<button id="agregarInsumo" type="button"
								class="btn btn-primary pull-right" onclick="agregarInsumo();">
								<i class="fa fa-plus-circle"> Agregar Insumo</i>
							</button>

						</div>
						<!-- /.box-header -->
						<div class="box-body">
							<div class="row">

								<div class="col-sm-12">
									<table id="listaInsumos"
										class="table table-striped table-bordered table-hover">

										<thead>
											<tr>
												<th>N°</th>
												<th>Nombre</th>
												<th>Tipo</th>
												<th>Unidad Medida</th>
												<th>Marca</th>
												<th></th>

											</tr>
										</thead>

										<tbody>

											<c:forEach var="listaInsumos" items="${listaInsumos }"
												varStatus="loop">
												<tr>
													<c:set var="index" value="${loop.index}" />
													<c:set var="index" value="${index + 1}" />

													<td><c:out value="${index}"></c:out></td>
													<td><c:out value="${listaInsumos.nombre}"></c:out></td>
													<td><c:out value="${listaInsumos.tipo}"></c:out></td>
													<td><c:out value="${listaInsumos.unidadMedida}"></c:out></td>
													<td><c:out value="${listaInsumos.marca}"></c:out></td>
													<td><a href="#"
														onclick="editarInsumo(${listaInsumos.idInsumo});"><i
															class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
														href="#"
														onclick="eliminarInsumo(${listaInsumos.idInsumo});"><i
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


			<div class="modal fade" id="modalAgregarInsumo" tabindex="-1"
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
											<select class="form-control" id="umInsumo">
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


			<!-- Modal editar -->


			<div class="modal fade" id="modalEditarInsumo" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">

							<h4 class="modal-title" id="myModalLabel">Editar Insumo</h4>
						</div>
						<div class="modal-body">


							<div class="row">

								<div class="box-body">

									<div id="form-editar" class="form-group">

										<div style="display: none">
											<input id="idInsumoEditar" />
										</div>

										<label class="col-sm-4 control-label">* Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="nombreInsumoEditar"> <span
												id="errorNombreEditar" class="error" style="display: none">Ingrese
												el nombre del insumo</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">*
											Tipo</label>
										<div class="col-sm-6">
											<select class="form-control" id="tipoInsumoEditar">


											</select> <span id="errorTipoEditar" class="error"
												style="display: none">Seleccione el tipo de insumo</span>
										</div>

										<br> <br> <label class="col-sm-4 control-label">*
											Unidad de Medida</label>

										<div class="col-sm-6">
											<select class="form-control" id="umInsumoEditar">

											</select> <span id="errorUMEditar" class="error" style="display: none">Seleccione
												la unidad de medida</span>
										</div>
										<br> <br> <label class="col-sm-4 control-label">&nbsp;&nbsp;&nbsp;Marca</label>

										<div class="col-sm-6">
											<input type="text" class="form-control"
												id="marcaInsumoEditar">
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
									onclick="guardarDatosInsumoEditar();">Actualizar</button>
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

<script src="js/listarInsumos.js">
	
</script>

</html>