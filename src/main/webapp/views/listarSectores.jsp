<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html>
<head>
<%@ include file="cabecera.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">

		<header class="main-header"> <%@ include
			file="barraSuperior.jsp"%> </header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar"> <%@ include
			file="barraLateral.jsp"%> <!-- /.sidebar -->
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
							
							<button class="btn btn-primary pull-right" data-toggle="modal" data-target="#modalAgregarSector" id="AgregarSector" type="button"
							><i class="fa fa-plus-circle"> Agregar Sector</i></button>
							
						</div>
                              <!-- Modal -->
                                <p></p>
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

										<label class="col-sm-4 control-label">Nombre</label>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="nombreSector">
										</div>
										<br> <br> <label class="col-sm-4 control-label">Superficie</label>

										<div class="col-sm-6">
											<input type="text" class="form-control" id="superficieSector">
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
						<div class="box-body">
							<div class="row">
								<div class="col-xs-12">
									<table id="listaSectores" class="table table-striped table-bordered table-hover">
										<thead>
											<tr>
												<th>Nº</th>
												<th>Nombre</th>
												<th>Superficie</th>

											</tr>
										</thead>
										<c:set var="i" value="0" />
										<c:forEach var="sector" items="${sectores}">
											<c:set var="i" value="${i+1}" />
											<tr>


												<td><c:out value="${i}"></c:out></td>
												<td><c:out value="${sector.nombre}"></c:out></td>
												<td><c:out value="${sector.superficie}"></c:out></td>

											</tr>
										</c:forEach>

									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			</section>

			<!-- Main content -->

		</div>

		<!-- /.content-wrapper -->

		<footer align="center" class="main-footer"
			style="background-color:#ecf0f5;"> <%@ include
			file="pieDePagina.jsp"%> </footer>
		<div class="control-sidebar-bg"></div>


	</div>
	<%@ include file="scripts.jsp"%>
</body>

 <script>

	function guardarDatosSector() {
		//Obtener los datos
		var nombreSector = $('#nombreSector').val();
		var  superficieSector = $('#superficieSector').val();

		console.log(nombreSector);
		console.log(superficieSector);

		$.ajax({
			type : 'POST',
			url : "agregarSector",
			dataType : 'json',
			data : {
				nombre : nombreSector,
			  superficie : superficieSector,

			},
			success : function(data) {
				console.log(data);
			},
			error : function(jqXHR, errorThrown) {
				alert("Error al guardar el sector");
			}
		});
	}
</script>



<script>
	$('#listaSectores').DataTable({
		'dom' : 'Bfrtip',
		'paging' : true,
		'lengthChange' : true,
		'searching' : false,
		'ordering' : false,
		'info' : true,
		'autoWidth' : true,
		'responsive' : true,
		"language" : {
			"sProcessing" : "Procesando...",
			"sLengthMenu" : "Mostrar _MENU_ registros",
			"sZeroRecords" : "No se encontraron resultados",
			"sEmptyTable" : "Ningún dato disponible en esta tabla",
			"sInfo" : "",
			"sInfoEmpty" : "No hay datos para mostrar",
			"sInfoFiltered" : "(filtrado de un total de _MAX_ registros)",
			"sInfoPostFix" : "",
			"sSearch" : "Buscar:",
			"sUrl" : "",
			"sInfoThousands" : ",",
			"sLoadingRecords" : "Cargando...",
			"oPaginate" : {
				"sFirst" : "Primero",
				"sLast" : "Último",
				"sNext" : "Siguiente",
				"sPrevious" : "Anterior"
			}
		}
	})
</script>
</html>