function PrediosDeunSector() {
	var idSector = $("#sectorSeleccionado").val();

	console.log(idSector);

	if (idSector > 0) {

		$
				.ajax({
					type : 'POST',
					url : "obtenerPrediosDeUnSector",
					dataType : 'json',
					data : {
						idSector : idSector
					},
					success : function(data) {

						if (!$.isEmptyObject(data)) {
							document.getElementById('sectorSeleccionado').style.border = "";
							document.getElementById('sinPredio').style.display = 'none';

							// Vaciar select
							$("#predioSeleccionado").empty();
							$("#predioSeleccionado")
									.append(
											'<option value="-1">Seleccione un predio</option>');
							for (var i = 0; i < data.length; i++) {
								$("#predioSeleccionado").append(
										'<option value=' + data[i].idPredio
												+ '>' + data[i].nombre
												+ '</option>');

							}
						} else {
							document.getElementById('sectorSeleccionado').style.border = "1px solid red";
							document.getElementById('sinPredio').style.display = 'inline';
							$("#predioSeleccionado").empty();
							$("#predioSeleccionado")
									.append(
											'<option value="-1">Seleccione un predio</option>');
						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error");
					}
				});

	}
	document.getElementById('sinPredio').style.display = 'none';

}

function mostrarPlanes() {
	var idTemporada = $("#temporadaSeleccionada").val();

	console.log(idTemporada);

	if (idTemporada > 0) {
		document.getElementById('divPlanes').style.display = 'inline';

	} else {
		document.getElementById('divPlanes').style.display = 'none';
	}

}

function actividadesDeUnPlan() {
	var idPlan = $("#planSeleccionado").val();
	var idTemporada = $("#temporadaSeleccionada").val();
	var fechaInicio;
	var fechaFinal;

	// Vaciar tabla
	var oTableIngre = document.getElementById('tablaActividades');

	// gets rows of table
	var rowLengthoTableIngre = oTableIngre.rows.length;

	for (t = 1; t < rowLengthoTableIngre; t++) {
		var Table = document.getElementById('tablaActividades');
		if (Table.rows.length > 0) {
			Table.deleteRow(1);

		}
	}

	console.log(idPlan);

	if (idPlan > 0) {

		$
				.ajax({
					type : 'POST',
					url : "obtenerFechasTemporada",
					dataType : 'json',
					async : false,
					data : {
						idTemporada : idTemporada
					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {
							fechaInicio = data.fechaInicio;
							fechaTermino = data.fechaTermino;

							console.log(fechaInicio);

							$
									.ajax({
										type : 'POST',
										url : "obtenerListaActididadesPlan",
										dataType : 'json',
										async : false,
										data : {
											idPlan : idPlan
										},
										success : function(data) {
											console.log(data);
											if (!$.isEmptyObject(data)) {
												// Cargar los datos a la tabla
												for (var i = 0; i < data.length; i++) {
													// N° Filas
													var filas = document
															.getElementById("tablaActividades").rows.length;
													console.log("filas: "
															+ filas);

													if (filas >= 1) {
														// Agregar el nombre de
														// la actividad a la
														// tabla

														// numero
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

														// Find a <table>
														// element with
														// id="myTable":
														var table = document
																.getElementById("tablaActividades");

														// Create an empty <tr>
														// element and add it to
														// the 1st position of
														// the table:
														var row = table
																.insertRow(filas);

														var cell1 = row
																.insertCell(0);
														var cell2 = row
																.insertCell(1);
														var cell3 = row
																.insertCell(2);
														var cell4 = row
																.insertCell(3);
														cell1.innerHTML = num;
														cell2.innerHTML = data[i].nombre;
														var min = new Date();
														console.log(min);
														fechaMin = moment(min,
																'YYYY/MM/DD');
														fechaMin = fechaMin
																.format('YYYY-MM-DD');

														console.log(fechaMin);
														if (fechaInicio > fechaMin) {

															cell3.innerHTML = '<input type="date" id="fechaEstimada"  style="width:200px;height:30px;text-align: center" min="'
																	+ fechaInicio
																	+ '" max="'
																	+ fechaTermino
																	+ '" class="form-control select2 select2-hidden-accessible"/>';
														} else {
															cell3.innerHTML = '<input type="date" id="fechaEstimada"  style="width:200px;height:30px;text-align: center" min="'
																	+ fechaMin
																	+ '" max="'
																	+ fechaTermino
																	+ '" class="form-control select2 select2-hidden-accessible"/>';
														}
														cell4.innerHTML = data[i].idActividad;

													}

												}

												fechaInicio = moment(
														fechaInicio,
														'YYYY/MM/DD');
												fechaInicio = fechaInicio
														.format('DD-MM-YYYY');

												fechaTermino = moment(
														fechaTermino,
														'YYYY/MM/DD');
												fechaTermino = fechaTermino
														.format('DD-MM-YYYY');

												$("#fechaInicio").text(
														fechaInicio);
												$("#fechaTermino").text(
														fechaTermino);

												// Ocultar la columna id
												// actividad
												var tbl = document
														.getElementById("tablaActividades");
												for (var i = 0; i < tbl.rows.length; i++) {

													for (var j = 0; j < tbl.rows[i].cells.length; j++) {

														tbl.rows[i].cells[j].style.display = "";

														if (j == 3)

															tbl.rows[i].cells[j].style.display = "none";

													}

												}
												document
														.getElementById('divTablaActividades').style.display = 'inline';

											}
										},
										error : function(jqXHR, errorThrown) {
											alert("Error al obtener las actividades");
										}
									});
						}

					},
					error : function(jqXHR, errorThrown) {
						alert("Error al obtener las actividades");
					}
				});

	} else {
		document.getElementById('divTablaActividades').style.display = 'none';
	}
}

function guardarDatos() {
	// Recorrer Tabla y Guardar los datos en un arreglo

	// obtener los dato de la tabla
	var oTable = document.getElementById('tablaActividades');
	// gets rows of table
	var rowLength = oTable.rows.length;
	console.log(rowLength);
	var cont = 0;

	var arregloFechas = Array();
	var arregloIds = Array();

	if (rowLength > 1) {
		// loops through rows
		for (i = 1; i < rowLength; i++) {
			var oCells = oTable.rows.item(i).cells;// devuelve un objeto con la
													// fila completa
			console.log(oCells[0].innerHTML);// Numero fila
			console.log(oCells[1].innerHTML);// Nombre Actividad
			console.log(oCells[2].innerHTML);// Fecha estimada
			console.log(oCells[3].innerHTML);// id actividad

			// var fecha = $('#fechaEstimada').val();
			// arregloFechas.push(oCells[2].value);
			arregloIds.push(oCells[3].innerHTML);// almacena los ids
			console.log(arregloIds);

		}
	}

	var filas = $("#tablaActividades").find("tr"); // devulve las filas del
													// body de tu tabla segun el
													// ejemplo que brindaste
	var fechas = "";
	for (i = 1; i < filas.length; i++) { // Recorre las filas 1 a 1
		var celdas = $(filas[i]).find("td"); // devolverá las celdas de una
												// fila
		fechas = $($(celdas[2]).children("input")[0]).val();
		if (fechas != "") {
			arregloFechas.push(fechas);
		}
	}

	console.log(arregloFechas);

	// Obtener los datos del sector
	var sectorSeleccionado = $('#sectorSeleccionado').val();
	// Obtener los datos del predio
	var predioSeleccionado = $('#predioSeleccionado').val();

	// Obtener los datos de la temporada
	var temporadaSeleccionada = $('#temporadaSeleccionada').val();
	// Obtener los datos del plan
	var planSeleccionado = $('#planSeleccionado').val();
	var fechaEstimada = $('#fechaEstimada').val();

	if (sectorSeleccionado == -1) {
		document.getElementById('errorSector').style.display = 'inline';
		document.getElementById('sectorSeleccionado').style.border = "1px solid red";
	} else {
		document.getElementById('errorSector').style.display = 'none';
		document.getElementById('sectorSeleccionado').style.border = "";
	}

	if (predioSeleccionado < 0) {
		document.getElementById('errorPredio').style.display = 'inline';
		document.getElementById('predioSeleccionado').style.border = "1px solid red";
	} else {
		document.getElementById('errorPredio').style.display = 'none';
		document.getElementById('predioSeleccionado').style.border = "";
	}

	if (temporadaSeleccionada == -1) {
		document.getElementById('errorTemporada').style.display = 'inline';
		document.getElementById('temporadaSeleccionada').style.border = "1px solid red";
	} else {
		document.getElementById('errorTemporada').style.display = 'none';
		document.getElementById('temporadaSeleccionada').style.border = "";
	}

	if (planSeleccionado < 0) {
		document.getElementById('errorPlan').style.display = 'inline';
		document.getElementById('planSeleccionado').style.border = "1px solid red";
	} else {
		document.getElementById('errorPlan').style.display = 'none';
		document.getElementById('planSeleccionado').style.border = "";
	}

	if (sectorSeleccionado > 0 && predioSeleccionado > 0
			&& temporadaSeleccionada > 0 && planSeleccionado > 0
			&& arregloIds.length > 0
			&& arregloFechas.length == arregloIds.length) {

		document.getElementById('loader').style.display = 'inline';

		// Enviar arreglo
		$
				.ajax({
					type : 'POST',
					url : "agregarPlanAPredio",
					dataType : 'json',
					data : {
						idPredio : predioSeleccionado,
						idTemporada : temporadaSeleccionada,
						actividadesFecha : arregloFechas,
						actividades : arregloIds

					},
					success : function(data) {
						if (data == true) {
							toastr.success("Asignación exitosa");
							document.getElementById('divTablaActividades').style.display = 'none';
							$('#sectorSeleccionado').val(-1);
							$("#predioSeleccionado").empty();
							$("#predioSeleccionado")
									.append(
											'<option value="-1">Seleccione un predio</option>');
							$('#temporadaSeleccionada').val(-1);
							$('#planSeleccionado').val(-1);
							// $('#predioSeleccionado').val("");
							document.getElementById('loader').style.display = 'none';

						} else {
							toastr
									.error("Error al registrar la actividad realizada");
						}
					},
					error : function(jqXHR, errorThrown) {
						toastr
								.error("Error al guardar los datos, verifique los datos ingresados");
						document.getElementById('loader').style.display = 'none';
					}
				});
	} else {
		toastr.error("Error, verificar datos ingresados");
	}
}