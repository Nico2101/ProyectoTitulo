var fechaHoy = new Date();
fechaHoy = moment(fechaHoy, 'YYYY/MM/DD');
fechaHoy = fechaHoy.format('YYYY-MM-DD');

$('#fechaCreacion').val(fechaHoy);

// Ocultar la columna check
var tbl = document.getElementById("tablaActividades");
for (var i = 0; i < tbl.rows.length; i++) {

	for (var j = 0; j < tbl.rows[i].cells.length; j++) {

		tbl.rows[i].cells[j].style.display = "";

		if (j == 3)

			tbl.rows[i].cells[j].style.display = "none";

	}

}

function modalAgregarActividad() {
	$('#nombreActividad').val("");
	$('#modalAgregarActividad').modal('show');
	document.getElementById('errorNombreActividad').style.display = 'none';
	document.getElementById('nombreActividad').style.border = "";
	if ($('#checkCosecha').prop('checked')) {
		$('#checkCosecha').prop('checked', false);
	}
	// $('#nombreActividad').focus();
}

function agregarDatosActividad() {
	var nombreActividad = $('#nombreActividad').val();

	if (nombreActividad == "") {
		document.getElementById('errorNombreActividad').style.display = 'inline';
		document.getElementById('nombreActividad').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombreActividad').style.display = 'none';
		document.getElementById('nombreActividad').style.border = "";
	}

	if (nombreActividad != "") {
		// Agregar el dato de la actividad a la tabla

		// N° Filas
		var filas = document.getElementById("tablaActividades").rows.length;
		console.log("filas: " + filas);

		if (filas >= 1) {
			// Agregar el nombre de la actividad a la tabla

			// numero
			var num = 0;
			var oTable = document.getElementById('tablaActividades');

			var rowLength = oTable.rows.length;
			var oCells = oTable.rows.item(rowLength - 1).cells;
			var n = oCells[0].textContent;

			if (n == "N°") {
				num = 1;
			} else {
				num = parseInt(n) + 1;
			}

			// Find a <table> element with id="myTable":
			var table = document.getElementById("tablaActividades");

			// Create an empty <tr> element and add it to the 1st position of
			// the table:
			var row = table.insertRow(filas);

			// Insert new cells (<td> elements) at the 1st and 2nd position of
			// the "new" <tr> element:
			var cell1 = row.insertCell(0);
			var cell2 = row.insertCell(1);
			var cell3 = row.insertCell(2);
			var cell4 = row.insertCell(3);

			// Add some text to the new cells:
			cell1.innerHTML = num;
			cell2.innerHTML = nombreActividad;
			cell3.innerHTML = '<a href="#" onclick="editarActividad('
					+ num
					+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarActividad('
					+ num
					+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>';
			if ($('#checkCosecha').prop('checked')) {
				cell4.innerHTML = 1;
			} else {
				cell4.innerHTML = 0;
			}

			$('#nombreActividad').val("");
			$('#nombreActividad').focus();
			var suma = num + 1;
			$('#actividadIngresar').text("Nombre Actividad " + suma);

			// Ocultar la columna check
			var tbl = document.getElementById("tablaActividades");
			for (var i = 0; i < tbl.rows.length; i++) {

				for (var j = 0; j < tbl.rows[i].cells.length; j++) {

					tbl.rows[i].cells[j].style.display = "";

					if (j == 3)

						tbl.rows[i].cells[j].style.display = "none";

				}

			}

		}
	}
}

function agregarActividadEditada() {
	var numFila = localStorage.getItem("numFila");
	console.log(numFila);

	var nombreActividad = $('#nombreActividadEditar').val();

	if (nombreActividad == "") {
		document.getElementById('errorNombreActividadEditar').style.display = 'inline';
		document.getElementById('nombreActividadEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombreActividadEditar').style.display = 'none';
		document.getElementById('nombreActividadEditar').style.border = "";
	}

	if (nombreActividad != "" && numFila > 0) {
		var oTable = document.getElementById('tablaActividades');
		// gets rows of table
		var rowLength = oTable.rows.length;

		// loops through rows
		for (i = 0; i < rowLength; i++) {
			var oCells = oTable.rows.item(i).cells;// devuelve un objeto con la
													// fila completa
			if (numFila == oCells[0].textContent) {
				oCells[1].innerHTML = nombreActividad;

				if ($('#checkCosechaEditar').prop('checked')) {
					oCells[3].innerHTML = 1;
				} else {
					oCells[3].innerHTML = 0;
				}
			}
		}
	}

	$('#modalEditarActividad').modal('hide');
}

function editarActividad(numFila) {
	var oTable = document.getElementById('tablaActividades');
	// gets rows of table
	var rowLength = oTable.rows.length;

	// loops through rows
	for (i = 0; i < rowLength; i++) {
		var oCells = oTable.rows.item(i).cells;// devuelve un objeto con la
												// fila completa

		if (numFila == oCells[0].textContent) {
			var table = document.getElementById("tablaActividades");
			console.log("TABLE: ");
			console.log(table);
			if (table.rows.length > 0) {

				var num = numFila;

				var nombre = oCells[1].textContent;
				var check = oCells[3].textContent;

				if (check == 1) {
					$('#checkCosechaEditar').prop('checked', true);
				}

				$('#nombreActividadEditar').val(nombre);
				document.getElementById('errorNombreActividadEditar').style.display = 'none';
				document.getElementById('nombreActividadEditar').style.border = "";

				localStorage.setItem("numFila", numFila);
				// mostrar el modal para editar la actividad
				$('#modalEditarActividad').modal('show');
			}
		}

	}
}

function eliminarActividad(numFila) {
	swal(
			{
				title : "¿Está seguro de eliminar la actividad?",
				text : "Esta acción no podrá ser recuperada",
				type : "warning",
				showCancelButton : true,
				confirmButtonClass : "btn-danger",
				cancelButtonText : "Cancelar",
				confirmButtonText : "Si, Eliminar",
				closeOnConfirm : false
			},
			function() {
				var oTable = document.getElementById('tablaActividades');

				// gets rows of table
				var rowLength = oTable.rows.length;

				var eliminado = false;
				// loops through rows
				for (var i = 1; i < rowLength; i++) {
					var oCells = oTable.rows.item(i).cells;// devuelve un
															// objeto con la
															// fila completa

					if (numFila == oCells[0].textContent) {
						if (oTable.rows.length > 0) {
							console.log("valor de i: " + i);
							oTable.deleteRow(i);
							toastr.success("Se ha eliminado la fila N°: "
									+ numFila + " correctamente!");
							oTable = document
									.getElementById('tablaActividades');
							i = oTable.rows.length;
							eliminado = true;
						}
					}

					if (eliminado == true) {
						break;
					}

				}
				swal.close();

				// Actualizar numero de la tabla

				oTable = document.getElementById('tablaActividades');
				// gets rows of table
				rowLength = oTable.rows.length;

				for (var i = 1; i < rowLength; i++) {
					var oCells = oTable.rows.item(i).cells;// devuelve un
															// objeto con la
															// fila completa

					oCells[0].innerHTML = i;
					oCells[2].innerHTML = '<a href="#" onclick="editarActividad('
							+ i
							+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarActividad('
							+ i
							+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>';

				}

			});

}

function guardarDatos() {

	// Obtener los datos del plan
	var nombrePlan = $('#nombrePlan').val();
	var fechaCreacion = $('#fechaCreacion').val();

	if (nombrePlan == "") {
		document.getElementById('errorNombrePlan').style.display = 'inline';
		document.getElementById('nombrePlan').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombrePlan').style.display = 'none';
		document.getElementById('nombrePlan').style.border = "";
	}

	if (fechaCreacion == "") {
		document.getElementById('errorFechaCreacion').style.display = 'inline';
		document.getElementById('fechaCreacion').style.border = "1px solid red";
		document.getElementById('errorFechaCreacionMayor').style.display = 'none';
	} else {
		var fecha = new Date();
		fecha = moment(fecha, 'YYYY/MM/DD');
		fecha = fecha.format('DD-MM-YYYY');

		fechaC = moment(fechaCreacion, 'YYYY/MM/DD');
		fechaC = fechaC.format('DD-MM-YYYY');

		if (fechaC > fecha) {
			document.getElementById('errorFechaCreacion').style.display = 'none';
			document.getElementById('errorFechaCreacionMayor').style.display = 'inline';
			document.getElementById('fechaCreacion').style.border = "1px solid red";
		} else {
			document.getElementById('errorFechaCreacion').style.display = 'none';
			document.getElementById('fechaCreacion').style.border = "";
			document.getElementById('errorFechaCreacionMayor').style.display = 'none';
		}

	}

	var oTable = document.getElementById('tablaActividades');
	// gets rows of table
	var rowLength = oTable.rows.length;

	if (rowLength > 1) {
		document.getElementById('errorTablaVacia').style.display = 'none';
	} else {
		document.getElementById('errorTablaVacia').style.display = 'inline';
	}

	if (rowLength > 1 && nombrePlan != "" && fechaCreacion != "") {

		var arregloActividades = Array();

		// obtener las actividades de la tabla
		for (var i = 1; i < rowLength; i++) {
			var oCells = oTable.rows.item(i).cells;// devuelve un objeto con la
													// fila completa
			arregloActividades.push(oCells[1].innerText);
			// Enviar 1 si es cosecha 0 si no
			arregloActividades.push(oCells[3].innerText);
		}

		console.log(arregloActividades);

		$
				.ajax({
					type : 'POST',
					url : "verificarNombreRepetidoPlan",
					dataType : 'json',
					data : {
						nombre : nombrePlan
					},
					success : function(data) {
						console.log(data);
						if (data == true) {
							swal(
									{
										title : "Ya existe un plan con el nombre ingresado ¿Desea continuar?",
										text : "",
										type : "warning",
										showCancelButton : true,
										confirmButtonClass : "btn-danger",
										cancelButtonText : "Cancelar",
										confirmButtonText : "Si, continuar",
										closeOnConfirm : false
									},
									function() {

										$
												.ajax({
													type : 'POST',
													url : "agregarPlanYActividades",
													dataType : 'json',
													data : {
														nombrePlan : nombrePlan,
														fecha : fechaCreacion,
														actividades : arregloActividades

													},
													success : function(data) {
														console.log(data);
														if (data == true) {
															swal.close();
															toastr
																	.success("El plan ha sido agregado correctamente");
															$('#nombrePlan')
																	.val("");
															$('#fechaCreacion')
																	.val("");

															var fechaHoy = new Date();
															fechaHoy = moment(
																	fechaHoy,
																	'YYYY/MM/DD');
															fechaHoy = fechaHoy
																	.format('YYYY-MM-DD');

															$('#fechaCreacion')
																	.val(
																			fechaHoy);

															// Vaciar tabla
															// Vaciar tabla
															// materiales
															var ot = document
																	.getElementById('tablaActividades');
															var tam = ot.rows.length;
															// loops through
															// rows
															var w = 0;
															for (w = 1; w < tam; w++) {
																var ot2 = document
																		.getElementById('tablaActividades');
																if (ot2.rows.length > 0) {
																	ot2
																			.deleteRow(1);

																}
															}

														} else {
															toastr
																	.error("Se ha producido un error al guardar el plan");
														}

													},
													error : function(jqXHR,
															errorThrown) {
														alert("Error al guardar el plan");
													}
												});
									});
						} else {
							$
									.ajax({
										type : 'POST',
										url : "agregarPlanYActividades",
										dataType : 'json',
										async : false,
										data : {
											nombrePlan : nombrePlan,
											fecha : fechaCreacion,
											actividades : arregloActividades
										},
										success : function(data) {
											console.log(data);
											if (data == true) {
												swal.close();
												toastr
														.success("El plan ha sido agregado correctamente");
												$('#nombrePlan').val("");
												$('#fechaCreacion').val("");

												var fechaHoy = new Date();
												fechaHoy = moment(fechaHoy,
														'YYYY/MM/DD');
												fechaHoy = fechaHoy
														.format('YYYY-MM-DD');

												$('#fechaCreacion').val(
														fechaHoy);

												// Vaciar tabla
												// Vaciar tabla materiales
												var ot = document
														.getElementById('tablaActividades');
												var tam = ot.rows.length;
												// loops through rows
												var w = 0;
												for (w = 1; w < tam; w++) {
													var ot2 = document
															.getElementById('tablaActividades');
													if (ot2.rows.length > 0) {
														ot2.deleteRow(1);

													}
												}

											} else {
												toastr
														.error("Se ha producido un error al guardar el plan");
											}

										},
										error : function(jqXHR, errorThrown) {
											alert("Error al guardar el plan");
										}
									});
						}
					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error, revisar datos");
					}
				});

	}
}