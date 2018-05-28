
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="libreria.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="cabecera.jsp"%>

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
							<h3 class="box-title">Reprogramar Actividades</h3>

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
											planes asignados</span>
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
									<div class="col-sm-2" style="text-align: center;"></div>

									<div class="col-sm-7">
										<table id="tablaActividades"
											class="table table-striped table-bordered table-hover">

											<thead>
												<tr>

													<th>N°</th>
													<th width="400px">Nombre Actividad</th>
													<th width="250px">Fecha Estimada</th>
													<th>id actividad</th>

												</tr>
												
											</thead>

										</table>
										<label>Motivo de reprogramación de actividades:</label>
										<p> <textarea name="motivo" id="motivo" cols="103" rows="3"></textarea></p>

									</div>
									<div class="col-sm-3"></div>

								</div>
								<br>

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
			file="pieDePagina.jsp"%> </footer>

		<div class="control-sidebar-bg"></div>

	</div>
	<%@ include file="scripts.jsp"%>
</body>

<script>
	function buscarPrediosSector() {

		var idSector = $('#sector').val();
		console.log(idSector);

		if (idSector > 0) {
			document.getElementById('errorSector').style.display = 'none';
			document.getElementById('sector').style.border = "";

			//Obtener los predios
			$
					.ajax({
						type : 'POST',
						url : "obtenerPrediosDelSectorConPlanAsignado",
						dataType : 'json',
						data : {
							idSector : idSector
						},
						success : function(data) {

							if (!$.isEmptyObject(data)) {
								document.getElementById('sector').style.border = "";
								document.getElementById('sinPredio').style.display = 'none';
								//Contruir el proximo select predio
								//Vaciar select
								$("#predio").empty();
								$("#predio")
										.append(
												'<option value="-1">Seleccione un predio</option>');
								for (var i = 0; i < data.length; i++) {
									$("#predio").append(
											'<option value='+data[i].idPredio+'>'
													+ data[i].nombre
													+ '</option>');

								}

								document.getElementById('divPredio').style.display = 'inline';

							} else {
								document.getElementById('divPredio').style.display = 'none';
								document.getElementById('sector').style.border = "1px solid red";
								document.getElementById('sinPredio').style.display = 'inline';
								document.getElementById('divPlanAsignado').style.display = 'none';
								document
										.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';
							}
						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener los predios");
						}
					});

		} else {
			document.getElementById('errorSector').style.display = 'inline';
			document.getElementById('divPredio').style.display = 'none';
			document.getElementById('sector').style.border = "1px solid red";
			document.getElementById('divPlanAsignado').style.display = 'none';
			document.getElementById('sinPredio').style.display = 'none';
			document.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';
		}

	}

	function mostrarActividades() {
		//Vaciar tabla
		var oTableIngre = document.getElementById('tablaActividades');

		//gets rows of table
		var rowLengthoTableIngre = oTableIngre.rows.length;

		for (t = 1; t < rowLengthoTableIngre; t++) {
			var Table = document.getElementById('tablaActividades');
			if (Table.rows.length > 0) {
				Table.deleteRow(1);

			}
		}

		//obtener el id del predio
		var idPredio = $('#predio').val();
		if (idPredio > 0) {
			$
					.ajax({
						type : 'POST',
						url : "obtenerActividadesDelPlanAsignadoAlPredio",
						dataType : 'json',
						data : {
							idPredio : idPredio
						},
						success : function(data) {
							console.log(data);
							if (!$.isEmptyObject(data)) {
								//Cargar los datos a la tabla
								for (var i = 0; i < data.length; i++) {
									//N° Filas
									var filas = document
											.getElementById("tablaActividades").rows.length;
									console.log("filas: " + filas);

									if (filas >= 1) {
										//Agregar el nombre de la actividad a la tabla

										//numero
										var num = 0;
										var oTable = document
												.getElementById('tablaActividades');

										var rowLength = oTable.rows.length;
										var oCells = oTable.rows
												.item(rowLength - 1).cells;
										var n = oCells[0].textContent;

										if (n == "N°") {
											num = 1;
										} else {
											num = parseInt(n) + 1;
										}

										// Find a <table> element with id="myTable":
										var table = document
												.getElementById("tablaActividades");

										// Create an empty <tr> element and add it to the 1st position of the table:
										var row = table.insertRow(filas);

										// Insert new cells (<td> elements) at the 1st and 2nd position of the "new" <tr> element:
										var cell1 = row.insertCell(0); //numero
										var cell2 = row.insertCell(1);//nombre
										var cell3 = row.insertCell(2);//fechaEstimada
										var cell4 = row.insertCell(3);//idActividad

										// Add some text to the new cells:
										cell1.innerHTML = num;
										cell2.innerHTML = data[i].actividad.nombre;

										var fecha = moment(
												data[i].fechaEstimada,
												'YYYY/MM/DD');
										fecha = fecha.format('DD-MM-YYYY');
										
										
										$('#fechaEstimada').val(fecha); //sirve para poner la fecha en el input

										cell3.innerHTML = '<input type="date" name="fecha" id="fechaEstimada"   class="form-control select2 select2-hidden-accessible"/>';
										
										cell4.innerHTML = data[i].idActividadRealizada;

										$('#planAsignado')
												.val(
														data[i].actividad.planEjecucion.nombre);

									}

								}

								//Ocultar la columna id actividad
								var tbl = document
										.getElementById("tablaActividades");
								for (var i = 0; i < tbl.rows.length; i++) {

									for (var j = 0; j < tbl.rows[i].cells.length; j++) {

										tbl.rows[i].cells[j].style.display = "";

										if (j == 3)

											tbl.rows[i].cells[j].style.display = "none";

									}

								}
								document.getElementById('divPlanAsignado').style.display = 'inline';
								document
										.getElementById('divTablaRegistrarActividadRealizada').style.display = 'inline';
							}
						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener las actividades del plan asignado al predio seleccionado");
						}
					});
		} else {
			document.getElementById('divPlanAsignado').style.display = 'none';
			document.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';
		}
	}

	/*function guardarDatos() {
		//Recorrer Tabla y Guardar los datos en un arreglo

		//obtener los dato de la tabla
		var oTable = document.getElementById('tablaActividades');
		//gets rows of table
		var rowLength = oTable.rows.length;
		console.log(rowLength);
		var cont = 0;

		var arregloDatos = Array();
		var arregloDatosCosecha = Array();

		if (rowLength > 1) {
			//loops through rows    
			for (i = 1; i < rowLength; i++) {
				var oCells = oTable.rows.item(i).cells;//devuelve un objeto con la fila completa
				console.log(oCells[0].innerHTML);//Numero Fila
				console.log(oCells[1].innerHTML);//Nombre Actividad
				console.log(oCells[2].innerHTML);//Fecha Estimada
				console.log(oCells[4].innerHTML);//Cantidad cosechada
				console.log(oCells[6].innerHTML);//Id Actividad

				var idFecha = "fechaEjecucion" + oCells[0].innerHTML;
				var fecha = $('#' + idFecha).val();
				if (typeof fecha != 'undefined' && fecha != "") {
					console.log(fecha); //Imprimir Fecha Ejecucion Real
					cont++;

					//Agregar los datos en un arreglo

					if (oCells[1].innerHTML == "Cosecha"
							|| oCells[1].innerHTML == "cosecha") {
						var cantCosechada = $('#cantidadCosechada').val();
						if (cantCosechada == "") {
							toastr
									.warning("Debe ingresar la cantidad cosechada");
							$('#cantidadCosechada').focus();
							break;
						} else {
							arregloDatosCosecha.push(oCells[6].innerHTML);//id actividad
							arregloDatosCosecha.push(oCells[2].innerHTML);//fecha ejecucion real
							arregloDatosCosecha.push(cantCosechada);//Cantidad Cosechada
						}

					} else {
						//la actividad no es cosecha por lo tanto se guarda en otro arreglo
						arregloDatos.push(oCells[6].innerHTML);//id actividad
						arregloDatos.push(oCells[2].innerHTML);//fecha ejecucion real
					}

				}

				//agregar al arreglo los datos

			}
		}

		if (cont == 0) {
			toastr
					.warning("Debe indicar la fecha de ejecución real por lo menos en una actividad");
		} else {

			if (arregloDatos.length > 0 || arregloDatosCosecha.length > 0) {
				//Recorrer nuevamente el arreglo para preguntar si agregó insumos utilizados
				//Recorrer ambos arreglos
				var cont1 = 0, cont2 = 0;

				if (arregloDatos.length > 0) {
					for (var i = 0; i < arregloDatos.length / 2; i++) {
						//Buscar si la actividad tiene insumos agregados
						$
								.ajax({
									type : 'POST',
									url : "verificarActividadInsumo",
									dataType : 'json',
									async : false,
									data : {
										idActividadRealizada : parseInt(arregloDatos[i])
									},
									success : function(data) {
										if (data == false) {
											//Obtener nombre actividad
											$
													.ajax({
														type : 'POST',
														url : "obtenerDatosActividadRealizada",
														dataType : 'json',
														async : false,
														data : {
															idActividadRealizada : parseInt(arregloDatos[i])
														},
														success : function(data) {
															console.log(data);
															toastr
																	.error("Debe agregar insumos a la actividad: "
																			+ data.actividad.nombre);
														},
														error : function(jqXHR,
																errorThrown) {
															alert("Error al obtener los de la actividad realizada");
														}
													});
											cont1 += 10000000;

										} else {
											cont1++;
										}

									},
									error : function(jqXHR, errorThrown) {
										alert("Error al buscar datos actividad_insumo");
									}
								});
						i += 2;
					}
				}

				if (arregloDatosCosecha.length > 0) {
					for (var i = 0; i < arregloDatosCosecha.length / 3; i++) {
						//Buscar si la actividad tiene insumos agregados
						$
								.ajax({
									type : 'POST',
									url : "verificarActividadInsumo",
									dataType : 'json',
									async : false,
									data : {
										idActividadRealizada : parseInt(arregloDatosCosecha[i])
									},
									success : function(data) {
										if (data == false) {
											//Obtener nombre actividad
											$
													.ajax({
														type : 'POST',
														url : "obtenerDatosActividadRealizada",
														dataType : 'json',
														async : false,
														data : {
															idActividadRealizada : parseInt(arregloDatosCosecha[i])
														},
														success : function(data) {
															console.log(data);
															toastr
																	.error("Debe agregar insumos a la actividad: "
																			+ data.actividad.nombre);
														},
														error : function(jqXHR,
																errorThrown) {
															alert("Error al obtener los de la actividad realizada");
														}
													});
											cont2 += 10000000;

										} else {
											cont2++;
										}

									},
									error : function(jqXHR, errorThrown) {
										alert("Error al buscar datos actividad_insumo");
									}
								});
						i += 3;
					}
				}

				console.log(cont1);
				console.log(cont2);
				console.log(arregloDatos.length);
				console.log(arregloDatosCosecha.length);
				//guardar los datos de arregloDatos
				if (cont1 == arregloDatos.length / 2 && arregloDatos.length > 0) {
					//Enviar arreglo
					$
							.ajax({
								type : 'POST',
								url : "guardarDatosActividadRealizada",
								dataType : 'json',
								async : false,
								data : {
									datos : arregloDatos
								},
								success : function(data) {
									if (data == true) {
										toastr
												.success("Actividad realizada registrada correctamente");
									} else {
										toastr
												.error("Error al registrar la actividad realizada");
									}
								},
								error : function(jqXHR, errorThrown) {
									alert("Error al guardar los datos");
								}
							});
				}

				//guardar los datos de arregloDatosCosecha
				if (cont2 == arregloDatosCosecha.length / 3
						&& arregloDatosCosecha.length > 0) {
					//Enviar arreglo
					$
							.ajax({
								type : 'POST',
								url : "guardarDatosActividadRealizadaCosecha",
								async : false,
								data : {
									datos : arregloDatosCosecha
								},
								dataType : 'json',
								success : function(data) {
									if (data == true) {
										toastr
												.success("Actividad realizada registrada correctamente");
									} else {
										toastr
												.error("Error al registrar la actividad realizada");
									}
								},
								error : function(jqXHR, errorThrown) {
									alert("Error al guardar los datos de cosecha");
								}
							});
				}

				//recargar pagina

				/*
				//ocultar div tabla
				document.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';

				//ocultar predio y plan
				document.getElementById('divPlanAsignado').style.display = 'none';
				document.getElementById('divPredio').style.display = 'none';

				$('#sector').val(-1);*/

				//recargar tabla actividades
			/*	if (cont2 == (arregloDatosCosecha.length / 3)) {
					if (cont1 == (arregloDatos.length / 2)) {
						mostrarActividades();
					}
				}

			}

		}

	}  */
</script>



=======
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="libreria.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="cabecera.jsp"%>

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
							<h3 class="box-title">Reprogramar Actividades</h3>

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
											planes asignados</span>
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
									<div class="col-sm-2" style="text-align: center;"></div>

									<div class="col-sm-7">
										<table id="tablaActividades"
											class="table table-striped table-bordered table-hover">

											<thead>
												<tr>

													<th>N°</th>
													<th width="400px">Nombre Actividad</th>
													<th width="250px">Fecha Estimada</th>
													<th>id actividad</th>

												</tr>
												
											</thead>

										</table>
										<label>Motivo de reprogramación de actividades:</label>
										<p> <textarea name="motivo" id="motivo" cols="103" rows="3"></textarea></p>

									</div>
									<div class="col-sm-3"></div>

								</div>
								<br>

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
			file="pieDePagina.jsp"%> </footer>

		<div class="control-sidebar-bg"></div>

	</div>
	<%@ include file="scripts.jsp"%>
</body>

<script>
	function buscarPrediosSector() {

		var idSector = $('#sector').val();
		console.log(idSector);

		if (idSector > 0) {
			document.getElementById('errorSector').style.display = 'none';
			document.getElementById('sector').style.border = "";

			//Obtener los predios
			$
					.ajax({
						type : 'POST',
						url : "obtenerPrediosDelSectorConPlanAsignado",
						dataType : 'json',
						data : {
							idSector : idSector
						},
						success : function(data) {

							if (!$.isEmptyObject(data)) {
								document.getElementById('sector').style.border = "";
								document.getElementById('sinPredio').style.display = 'none';
								//Contruir el proximo select predio
								//Vaciar select
								$("#predio").empty();
								$("#predio")
										.append(
												'<option value="-1">Seleccione un predio</option>');
								for (var i = 0; i < data.length; i++) {
									$("#predio").append(
											'<option value='+data[i].idPredio+'>'
													+ data[i].nombre
													+ '</option>');

								}

								document.getElementById('divPredio').style.display = 'inline';

							} else {
								document.getElementById('divPredio').style.display = 'none';
								document.getElementById('sector').style.border = "1px solid red";
								document.getElementById('sinPredio').style.display = 'inline';
								document.getElementById('divPlanAsignado').style.display = 'none';
								document
										.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';
							}
						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener los predios");
						}
					});

		} else {
			document.getElementById('errorSector').style.display = 'inline';
			document.getElementById('divPredio').style.display = 'none';
			document.getElementById('sector').style.border = "1px solid red";
			document.getElementById('divPlanAsignado').style.display = 'none';
			document.getElementById('sinPredio').style.display = 'none';
			document.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';
		}

	}

	function mostrarActividades() {
		//Vaciar tabla
		var oTableIngre = document.getElementById('tablaActividades');

		//gets rows of table
		var rowLengthoTableIngre = oTableIngre.rows.length;

		for (t = 1; t < rowLengthoTableIngre; t++) {
			var Table = document.getElementById('tablaActividades');
			if (Table.rows.length > 0) {
				Table.deleteRow(1);

			}
		}

		//obtener el id del predio
		var idPredio = $('#predio').val();
		if (idPredio > 0) {
			$
					.ajax({
						type : 'POST',
						url : "obtenerActividadesDelPlanAsignadoAlPredio",
						dataType : 'json',
						data : {
							idPredio : idPredio
						},
						success : function(data) {
							console.log(data);
							if (!$.isEmptyObject(data)) {
								//Cargar los datos a la tabla
								for (var i = 0; i < data.length; i++) {
									//N° Filas
									var filas = document
											.getElementById("tablaActividades").rows.length;
									console.log("filas: " + filas);

									if (filas >= 1) {
										//Agregar el nombre de la actividad a la tabla

										//numero
										var num = 0;
										var oTable = document
												.getElementById('tablaActividades');

										var rowLength = oTable.rows.length;
										var oCells = oTable.rows
												.item(rowLength - 1).cells;
										var n = oCells[0].textContent;

										if (n == "N°") {
											num = 1;
										} else {
											num = parseInt(n) + 1;
										}

										// Find a <table> element with id="myTable":
										var table = document
												.getElementById("tablaActividades");

										// Create an empty <tr> element and add it to the 1st position of the table:
										var row = table.insertRow(filas);

										// Insert new cells (<td> elements) at the 1st and 2nd position of the "new" <tr> element:
										var cell1 = row.insertCell(0); //numero
										var cell2 = row.insertCell(1);//nombre
										var cell3 = row.insertCell(2);//fechaEstimada
										var cell4 = row.insertCell(3);//idActividad

										// Add some text to the new cells:
										cell1.innerHTML = num;
										cell2.innerHTML = data[i].actividad.nombre;

										var fecha = moment(
												data[i].fechaEstimada,
												'YYYY/MM/DD');
										fecha = fecha.format('DD-MM-YYYY');
										$('#fechaEstimada').val(fecha);
										

										cell3.innerHTML = '<input type="date" name="fecha" id="fechaEstimada"   class="form-control select2 select2-hidden-accessible"/>';
										
										cell4.innerHTML = data[i].idActividadRealizada;

										$('#planAsignado')
												.val(
														data[i].actividad.planEjecucion.nombre);

									}

								}

								//Ocultar la columna id actividad
								var tbl = document
										.getElementById("tablaActividades");
								for (var i = 0; i < tbl.rows.length; i++) {

									for (var j = 0; j < tbl.rows[i].cells.length; j++) {

										tbl.rows[i].cells[j].style.display = "";

										if (j == 3)

											tbl.rows[i].cells[j].style.display = "none";

									}

								}
								document.getElementById('divPlanAsignado').style.display = 'inline';
								document
										.getElementById('divTablaRegistrarActividadRealizada').style.display = 'inline';
							}
						},
						error : function(jqXHR, errorThrown) {
							alert("Error al obtener las actividades del plan asignado al predio seleccionado");
						}
					});
		} else {
			document.getElementById('divPlanAsignado').style.display = 'none';
			document.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';
		}
	}

	/*function guardarDatos() {
		//Recorrer Tabla y Guardar los datos en un arreglo

		//obtener los dato de la tabla
		var oTable = document.getElementById('tablaActividades');
		//gets rows of table
		var rowLength = oTable.rows.length;
		console.log(rowLength);
		var cont = 0;

		var arregloDatos = Array();
		var arregloDatosCosecha = Array();

		if (rowLength > 1) {
			//loops through rows    
			for (i = 1; i < rowLength; i++) {
				var oCells = oTable.rows.item(i).cells;//devuelve un objeto con la fila completa
				console.log(oCells[0].innerHTML);//Numero Fila
				console.log(oCells[1].innerHTML);//Nombre Actividad
				console.log(oCells[2].innerHTML);//Fecha Estimada
				console.log(oCells[4].innerHTML);//Cantidad cosechada
				console.log(oCells[6].innerHTML);//Id Actividad

				var idFecha = "fechaEjecucion" + oCells[0].innerHTML;
				var fecha = $('#' + idFecha).val();
				if (typeof fecha != 'undefined' && fecha != "") {
					console.log(fecha); //Imprimir Fecha Ejecucion Real
					cont++;

					//Agregar los datos en un arreglo

					if (oCells[1].innerHTML == "Cosecha"
							|| oCells[1].innerHTML == "cosecha") {
						var cantCosechada = $('#cantidadCosechada').val();
						if (cantCosechada == "") {
							toastr
									.warning("Debe ingresar la cantidad cosechada");
							$('#cantidadCosechada').focus();
							break;
						} else {
							arregloDatosCosecha.push(oCells[6].innerHTML);//id actividad
							arregloDatosCosecha.push(oCells[2].innerHTML);//fecha ejecucion real
							arregloDatosCosecha.push(cantCosechada);//Cantidad Cosechada
						}

					} else {
						//la actividad no es cosecha por lo tanto se guarda en otro arreglo
						arregloDatos.push(oCells[6].innerHTML);//id actividad
						arregloDatos.push(oCells[2].innerHTML);//fecha ejecucion real
					}

				}

				//agregar al arreglo los datos

			}
		}

		if (cont == 0) {
			toastr
					.warning("Debe indicar la fecha de ejecución real por lo menos en una actividad");
		} else {

			if (arregloDatos.length > 0 || arregloDatosCosecha.length > 0) {
				//Recorrer nuevamente el arreglo para preguntar si agregó insumos utilizados
				//Recorrer ambos arreglos
				var cont1 = 0, cont2 = 0;

				if (arregloDatos.length > 0) {
					for (var i = 0; i < arregloDatos.length / 2; i++) {
						//Buscar si la actividad tiene insumos agregados
						$
								.ajax({
									type : 'POST',
									url : "verificarActividadInsumo",
									dataType : 'json',
									async : false,
									data : {
										idActividadRealizada : parseInt(arregloDatos[i])
									},
									success : function(data) {
										if (data == false) {
											//Obtener nombre actividad
											$
													.ajax({
														type : 'POST',
														url : "obtenerDatosActividadRealizada",
														dataType : 'json',
														async : false,
														data : {
															idActividadRealizada : parseInt(arregloDatos[i])
														},
														success : function(data) {
															console.log(data);
															toastr
																	.error("Debe agregar insumos a la actividad: "
																			+ data.actividad.nombre);
														},
														error : function(jqXHR,
																errorThrown) {
															alert("Error al obtener los de la actividad realizada");
														}
													});
											cont1 += 10000000;

										} else {
											cont1++;
										}

									},
									error : function(jqXHR, errorThrown) {
										alert("Error al buscar datos actividad_insumo");
									}
								});
						i += 2;
					}
				}

				if (arregloDatosCosecha.length > 0) {
					for (var i = 0; i < arregloDatosCosecha.length / 3; i++) {
						//Buscar si la actividad tiene insumos agregados
						$
								.ajax({
									type : 'POST',
									url : "verificarActividadInsumo",
									dataType : 'json',
									async : false,
									data : {
										idActividadRealizada : parseInt(arregloDatosCosecha[i])
									},
									success : function(data) {
										if (data == false) {
											//Obtener nombre actividad
											$
													.ajax({
														type : 'POST',
														url : "obtenerDatosActividadRealizada",
														dataType : 'json',
														async : false,
														data : {
															idActividadRealizada : parseInt(arregloDatosCosecha[i])
														},
														success : function(data) {
															console.log(data);
															toastr
																	.error("Debe agregar insumos a la actividad: "
																			+ data.actividad.nombre);
														},
														error : function(jqXHR,
																errorThrown) {
															alert("Error al obtener los de la actividad realizada");
														}
													});
											cont2 += 10000000;

										} else {
											cont2++;
										}

									},
									error : function(jqXHR, errorThrown) {
										alert("Error al buscar datos actividad_insumo");
									}
								});
						i += 3;
					}
				}

				console.log(cont1);
				console.log(cont2);
				console.log(arregloDatos.length);
				console.log(arregloDatosCosecha.length);
				//guardar los datos de arregloDatos
				if (cont1 == arregloDatos.length / 2 && arregloDatos.length > 0) {
					//Enviar arreglo
					$
							.ajax({
								type : 'POST',
								url : "guardarDatosActividadRealizada",
								dataType : 'json',
								async : false,
								data : {
									datos : arregloDatos
								},
								success : function(data) {
									if (data == true) {
										toastr
												.success("Actividad realizada registrada correctamente");
									} else {
										toastr
												.error("Error al registrar la actividad realizada");
									}
								},
								error : function(jqXHR, errorThrown) {
									alert("Error al guardar los datos");
								}
							});
				}

				//guardar los datos de arregloDatosCosecha
				if (cont2 == arregloDatosCosecha.length / 3
						&& arregloDatosCosecha.length > 0) {
					//Enviar arreglo
					$
							.ajax({
								type : 'POST',
								url : "guardarDatosActividadRealizadaCosecha",
								async : false,
								data : {
									datos : arregloDatosCosecha
								},
								dataType : 'json',
								success : function(data) {
									if (data == true) {
										toastr
												.success("Actividad realizada registrada correctamente");
									} else {
										toastr
												.error("Error al registrar la actividad realizada");
									}
								},
								error : function(jqXHR, errorThrown) {
									alert("Error al guardar los datos de cosecha");
								}
							});
				}

				//recargar pagina

				/*
				//ocultar div tabla
				document.getElementById('divTablaRegistrarActividadRealizada').style.display = 'none';

				//ocultar predio y plan
				document.getElementById('divPlanAsignado').style.display = 'none';
				document.getElementById('divPredio').style.display = 'none';

				$('#sector').val(-1);*/

				//recargar tabla actividades
			/*	if (cont2 == (arregloDatosCosecha.length / 3)) {
					if (cont1 == (arregloDatos.length / 2)) {
						mostrarActividades();
					}
				}

			}

		}

	}  */
</script>




</html>