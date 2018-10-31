function nombreVacio() {
	document.getElementById('errorNombreEmpleado').style.display = 'none';
	document.getElementById('nombreEmpleado').style.border = "";

}

function apellidoVacio() {
	document.getElementById('errorApellidosEmpleado').style.display = 'none';
	document.getElementById('apellidosEmpleado').style.border = "";

}

function rutVacio() {
	document.getElementById('errorRutEmpleado').style.display = 'none';
	document.getElementById('rutEmpleado').style.border = "";

}

function fechaNacimientoVacia() {
	document.getElementById('errorFechaNacimientoEmpleado').style.display = 'none';
	document.getElementById('fechaNacimientoEmpleado').style.border = "";

}

function direccionVacia() {
	document.getElementById('errorDireccionEmpleado').style.display = 'none';
	document.getElementById('direccionEmpleado').style.border = "";

}

function telefonoVacio() {
	document.getElementById('errorTelefonoEmpleado').style.display = 'none';
	document.getElementById('telefonoEmpleado').style.border = "";

}

function cargoVacio() {
	document.getElementById('errorCargoEmpleado').style.display = 'none';
	document.getElementById('cargoEmpleado').style.border = "";

}
function agregarEmpleado() {
	$('#modalAgregarEmpleado').modal('show');

	// Limpiar modal
	$('#rutEmpleado').val("");
	$('#nombreEmpleado').val("");
	$('#apellidosEmpleado').val("");
	$("#fechaNacimientoEmpleado").val("");
	$("#direccionEmpleado").val("");
	$("#telefonoEmpleado").val("");
	$("#cargoEmpleado").val(-1);

	document.getElementById('errorRutEmpleado').style.display = 'none';
	document.getElementById('rutEmpleado').style.border = "";

	document.getElementById('errorNombreEmpleado').style.display = 'none';
	document.getElementById('nombreEmpleado').style.border = "";

	document.getElementById('errorApellidosEmpleado').style.display = 'none';
	document.getElementById('apellidosEmpleado').style.border = "";

	document.getElementById('errorFechaNacimientoEmpleado').style.display = 'none';
	document.getElementById('fechaNacimientoEmpleado').style.border = "";

	document.getElementById('errorDireccionEmpleado').style.display = 'none';
	document.getElementById('direccionEmpleado').style.border = "";

	document.getElementById('errorTelefonoEmpleado').style.display = 'none';
	document.getElementById('telefonoEmpleado').style.border = "";

	document.getElementById('errorCargoEmpleado').style.display = 'none';
	document.getElementById('cargoEmpleado').style.border = "";

	document.getElementById('errorRutEmpleadoInvalido').style.display = 'none';
	document.getElementById('rutEmpleado').style.border = "";

	document.getElementById('errorFechaNacimientoSup').style.display = 'none';
	document.getElementById('fechaNacimientoEmpleado').style.border = "";

	document.getElementById('errorRutEmpleadoYaExiste').style.display = 'none';
	document.getElementById('rutEmpleado').style.border = "";

}

function guardarDatosEmpleado() {

	// Obtener los datos
	var rutEmpleado = $('#rutEmpleado').val();
	var nombreEmpleado = $('#nombreEmpleado').val();
	var apellidosEmpleado = $('#apellidosEmpleado').val();
	var fechaNacimientoEmpleado = $('#fechaNacimientoEmpleado').val();
	var direccionEmpleado = $('#direccionEmpleado').val();
	var telefonoEmpleado = $('#telefonoEmpleado').val();

	var cargo = document.getElementById("cargoEmpleado");
	var cargoEmpleado = cargo.options[cargo.selectedIndex].text;

	var hoy = new Date();
	var fechaNacimiento = new Date(fechaNacimientoEmpleado);

	var rutSolo = rutEmpleado.replace(".", "");

	var claveEmpleado = (nombreEmpleado.substring(0, 4) + rutSolo.substring(0,
			4));

	console.log(rutEmpleado);
	console.log(nombreEmpleado);
	console.log(apellidosEmpleado);
	console.log(fechaNacimiento);
	console.log(direccionEmpleado);
	console.log(telefonoEmpleado);
	console.log(cargoEmpleado);
	console.log(claveEmpleado);

	// Validacion para el rut
	if (rutEmpleado == "") {
		document.getElementById('errorRutEmpleado').style.display = 'inline';
		document.getElementById('rutEmpleado').style.border = "1px solid red";

	} else {
		document.getElementById('errorRutEmpleado').style.display = 'none';
		document.getElementById('rutEmpleado').style.border = "";
	}

	// Validacion para el nombre
	if (nombreEmpleado == "") {
		document.getElementById('errorNombreEmpleado').style.display = 'inline';
		document.getElementById('nombreEmpleado').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombreEmpleado').style.display = 'none';
		document.getElementById('nombreEmpleado').style.border = "";
	}

	// Validacion para los apellidos
	if (apellidosEmpleado == "") {
		document.getElementById('errorApellidosEmpleado').style.display = 'inline';
		document.getElementById('apellidosEmpleado').style.border = "1px solid red";
	} else {
		document.getElementById('errorApellidosEmpleado').style.display = 'none';
		document.getElementById('apellidosEmpleado').style.border = "";
	}

	// valida que la fecha sea inferior
	if (fechaNacimiento > hoy) {
		document.getElementById('errorFechaNacimientoSup').style.display = 'inline';
		document.getElementById('fechaNacimientoEmpleado').style.border = "1px solid red";
	} else {
		document.getElementById('errorFechaNacimientoSup').style.display = 'none';
		document.getElementById('fechaNacimientoEmpleado').style.border = "";
	}

	// Validacion par la fecha nacimiento
	if (fechaNacimientoEmpleado == "") {
		document.getElementById('errorFechaNacimientoEmpleado').style.display = 'inline';
		document.getElementById('fechaNacimientoEmpleado').style.border = "1px solid red";
	} else {
		document.getElementById('errorFechaNacimientoEmpleado').style.display = 'none';
		document.getElementById('fechaNacimientoEmpleado').style.border = "";
	}

	// Validacion para la direccion
	if (direccionEmpleado == "") {
		document.getElementById('errorDireccionEmpleado').style.display = 'inline';
		document.getElementById('direccionEmpleado').style.border = "1px solid red";
	} else {
		document.getElementById('errorDireccionEmpleado').style.display = 'none';
		document.getElementById('direccionEmpleado').style.border = "";
	}

	// Validacion para el telefono
	if (telefonoEmpleado == "") {
		document.getElementById('errorTelefonoEmpleado').style.display = 'inline';
		document.getElementById('telefonoEmpleado').style.border = "1px solid red";
	} else {
		document.getElementById('errorTelefonoEmpleado').style.display = 'none';
		document.getElementById('telefonoEmpleado').style.border = "";
	}

	// Validacion para el cargo
	if (cargoEmpleado == "Seleccione cargo") {
		document.getElementById('errorCargoEmpleado').style.display = 'inline';
		document.getElementById('cargoEmpleado').style.border = "1px solid red";
	} else {
		document.getElementById('errorCargoEmpleado').style.display = 'none';
		document.getElementById('cargoEmpleado').style.border = "";

	}

	$
			.ajax({
				type : 'POST',
				url : "validarRut",
				dataType : 'json',
				async : false,
				data : {
					rut : rutEmpleado
				},
				success : function(data) {
					if (data == true) {
						swal.close();
						document.getElementById('errorRutEmpleadoInvalido').style.display = 'none';
						document.getElementById('rutEmpleado').style.border = "";

						$
								.ajax({
									type : 'POST',
									url : "verificarRutRepetido",
									dataType : 'json',
									async : false,
									data : {
										rut : rutEmpleado
									},
									success : function(data) {
										if (data == true) {
											swal.close();
											document
													.getElementById('errorRutEmpleadoYaExiste').style.display = 'none';
											document
													.getElementById('rutEmpleado').style.border = "";

											if (nombreEmpleado != ""
													&& apellidosEmpleado != ""
													&& rutEmpleado != ""
													&& fechaNacimientoEmpleado != ""
													&& fechaNacimiento < hoy
													&& direccionEmpleado != ""
													&& telefonoEmpleado != ""
													&& cargoEmpleado != "Seleccione cargo") {

												$
														.ajax({
															type : 'POST',
															url : "agregarEmpleado",
															dataType : 'json',
															async : false,
															data : {
																rut : rutEmpleado,
																nombre : nombreEmpleado,
																apellidos : apellidosEmpleado,
																fechaNacimiento : fechaNacimientoEmpleado,
																direccion : direccionEmpleado,
																telefono : telefonoEmpleado,
																cargo : cargoEmpleado,
																clave : claveEmpleado
															},
															success : function(
																	data) {
																console
																		.log(data);

																if (data.rut != "") {
																	$(
																			'#modalAgregarEmpleado')
																			.modal(
																					'hide');

																	// Actualizar
																	// el
																	// data
																	// table
																	$
																			.ajax({
																				type : 'POST',
																				url : "obtenerListaEmpleados",
																				dataType : 'json',
																				success : function(
																						data) {

																					if (!$
																							.isEmptyObject(data)) {
																						// vaciar
																						// datatable
																						var oTable = $(
																								'#listaEmpleados')
																								.dataTable();
																						oTable
																								.fnClearTable();

																						// Llenar
																						// data
																						// table
																						for (var i = 0; i < data.length; i++) {
																							$(
																									'#listaEmpleados')
																									.dataTable()
																									.fnAddData(

																											[
																													i + 1,
																													data[i].nombre,
																													data[i].apellidos,
																													data[i].rut,
																													data[i].direccion,
																													data[i].telefono,
																													data[i].cargo,
																													'<a href="#" onclick="editarEmpleado(\''
																															+ data[i].rut
																															+ '\');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarEmpleado(\''
																															+ data[i].rut
																															+ '\');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																									);
																						}
																					}

																				},
																				error : function(
																						jqXHR,
																						errorThrown) {
																					toastr
																							.error("Error al obtener los empleados");
																				}
																			});

																	toastr
																			.success("Empleado agregado correctamente");
																} else {
																	toastr
																			.error("Error al agregar el empleado");
																}

															},
															error : function(
																	jqXHR,
																	errorThrown) {
																toastr
																		.error("Error al agregar el empleado");
															}
														});

											}

										} else {
											document
													.getElementById('errorRutEmpleadoYaExiste').style.display = 'inline';
											document
													.getElementById('rutEmpleado').style.border = "1px solid red";
											document
													.getElementById('errorRutEmpleadoInvalido').style.display = 'none';

										}

									},
									error : function(jqXHR, errorThrown) {
										toastr
												.error("Error al agregar el empleado1111");
									}
								});

					} else {
						document.getElementById('errorRutEmpleadoYaExiste').style.display = 'none';
						document.getElementById('rutEmpleado').style.border = "";

						if (rutEmpleado == "") {
							document.getElementById('errorRutEmpleadoInvalido').style.display = 'none';
							document.getElementById('rutEmpleado').style.border = "";
							document.getElementById('errorRutEmpleado').style.display = 'inline';
							document.getElementById('rutEmpleado').style.border = "1px solid red";

						} else {
							if (rutEmpleado != "") {
								document
										.getElementById('errorRutEmpleadoInvalido').style.display = 'inline';
								document.getElementById('rutEmpleado').style.border = "1px solid red";
							}

						}
					}

				},
				error : function(jqXHR, errorThrown) {

				}
			});

}
function editarEmpleado(rut) {
	console.log(rut);

	if (rut != "") {
		// Obtener los datos del empleado
		$
				.ajax({
					type : 'POST',
					url : "obtenerEmpleadoAEditar",
					dataType : 'json',
					data : {
						rut : rut
					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {
							// Cargar los datos en el modal
							$('#nombreEmpleadoEditar').val(data.nombre);
							$('#apellidosEmpleadoEditar').val(data.apellidos);
							$('#rutEditar').val(data.rut);
							$('#fechaNacimientoEmpleadoEditar').val(
									data.fechaNac);
							$('#direccionEmpleadoEditar').val(data.direccion);
							$('#telefonoEmpleadoEditar').val(data.telefono);

							$('#cargoEmpleadoEditar').empty();

							// obtengo los option de cargo del empleado
							var cargoEmpleado = $('#cargoEmpleado option');

							for (var i = 0; i < cargoEmpleado.length; i++) {
								if (cargoEmpleado[i].innerText == data.cargo) {
									$("#cargoEmpleadoEditar")
											.append(
													'<option value='
															+ cargoEmpleado[i].value
															+ ' selected>'
															+ cargoEmpleado[i].innerText
															+ '</option>');
								} else {
									$("#cargoEmpleadoEditar")
											.append(
													'<option value='
															+ cargoEmpleado[i].value
															+ '>'
															+ cargoEmpleado[i].innerText
															+ '</option>');
								}

							}

							document
									.getElementById('errorNombreEmpleadoEditar').style.display = 'none';
							document.getElementById('nombreEmpleadoEditar').style.border = "";

							document
									.getElementById('errorApellidosEmpleadoEditar').style.display = 'none';
							document.getElementById('apellidosEmpleadoEditar').style.border = "";

							document
									.getElementById('errorFechaNacimientoEmpleadoEditar').style.display = 'none';
							document
									.getElementById('fechaNacimientoEmpleadoEditar').style.border = "";

							document
									.getElementById('errorDireccionEmpleadoEditar').style.display = 'none';
							document.getElementById('direccionEmpleadoEditar').style.border = "";

							document
									.getElementById('errorTelefonoEmpleadoEditar').style.display = 'none';
							document.getElementById('telefonoEmpleadoEditar').style.border = "";

							document.getElementById('errorCargoEmpleadoEditar').style.display = 'none';
							document.getElementById('cargoEmpleadoEditar').style.border = "";

							document
									.getElementById('errorFechaNacimientoSuperiorEditar').style.display = 'none';
							document
									.getElementById('fechaNacimientoEmpleadoEditar').style.border = "";

							// Cargar el rut del empleado en el input oculto
							$('#rutEmpleadoEditar').val(rut);

							$('#modalEditarEmpleado').modal('show');

						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al editar el empleado");
					}
				});
	}

}

function eliminarEmpleado(rutEmpleado) {
	console.log(rutEmpleado);

	if (rutEmpleado != null) {
		swal(
				{
					title : "¿Está seguro de eliminar el empleado?",
					text : "Esta acción no podrá ser recuperada",
					type : "warning",
					showCancelButton : true,
					confirmButtonClass : "btn-danger",
					cancelButtonText : "Cancelar",
					confirmButtonText : "Si, Eliminar",
					closeOnConfirm : false
				},
				function() {

					// Ajax para eliminar
					$
							.ajax({
								type : 'POST',
								url : "eliminarEmpleado",
								dataType : 'json',
								data : {
									rutEmpleado : rutEmpleado
								},
								success : function(data) {
									if (data == true) {
										swal.close();
										toastr
												.success("Empleado eliminado correctamente");

										// Actualizar el data table
										$
												.ajax({
													type : 'POST',
													url : "obtenerListaEmpleados",
													dataType : 'json',
													success : function(data) {

														if (!$
																.isEmptyObject(data)) {
															// vaciar
															// datatable
															var oTable = $(
																	'#listaEmpleados')
																	.dataTable();
															oTable
																	.fnClearTable();

															// Llenar data
															// table
															for (var i = 0; i < data.length; i++) {
																$(
																		'#listaEmpleados')
																		.dataTable()
																		.fnAddData(

																				[
																						i + 1,
																						data[i].nombre,
																						data[i].apellidos,
																						data[i].rut,
																						data[i].direccion,
																						data[i].telefono,
																						data[i].cargo,
																						'<a href="#" onclick="editarEmpleado(\''
																								+ data[i].rut
																								+ '\');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarEmpleado(\''
																								+ data[i].rut
																								+ '\');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																		);
															}
														}

													},
													error : function(jqXHR,
															errorThrown) {
														toastr
																.error("Error al obtener los empleados");
													}
												});
									} else {
										toastr
												.error("Error al obtener los empleados");
									}

								},
								error : function(jqXHR, errorThrown) {
									toastr
											.error("Error al eliminar el empleado");
								}
							});

				});
	}

}

function guardarDatosEmpleadoEditar() {
	// Obtener los datos
	var rutEmpleadoEditar = $('#rutEmpleadoEditar').val();
	var nombreEmpleadoEditar = $('#nombreEmpleadoEditar').val();
	var apellidosEmpleadoEditar = $('#apellidosEmpleadoEditar').val();
	var fechaNacimientoEmpleadoEditar = $('#fechaNacimientoEmpleadoEditar')
			.val();
	var direccionEmpleadoEditar = $('#direccionEmpleadoEditar').val();
	var telefonoEmpleadoEditar = $('#telefonoEmpleadoEditar').val();

	var cargoEmpleado = document.getElementById("cargoEmpleadoEditar");
	var cargoEmpleadoEditar = cargoEmpleado.options[cargoEmpleado.selectedIndex].text;

	var hoy = new Date();
	var FechaNacimiento = new Date(fechaNacimientoEmpleadoEditar);

	var rutSoloEditar = rutEmpleadoEditar.replace(".", "");

	var claveEmpleadoEditar = (nombreEmpleadoEditar.substring(0, 4) + rutSoloEditar
			.substring(0, 4));

	console.log(nombreEmpleadoEditar);
	console.log(apellidosEmpleadoEditar);
	console.log(fechaNacimientoEmpleadoEditar);
	console.log(direccionEmpleadoEditar);
	console.log(telefonoEmpleadoEditar);
	console.log(cargoEmpleadoEditar);

	// Validacion para el rut
	if (rutEmpleado == "") {
		document.getElementById('errorRutEmpleado').style.display = 'inline';
		document.getElementById('rutEmpleado').style.border = "1px solid red";
	} else {
		document.getElementById('errorRutEmpleado').style.display = 'none';
		document.getElementById('rutEmpleado').style.border = "";
	}

	// Validacion para el nombre
	if (nombreEmpleadoEditar == "") {
		document.getElementById('errorNombreEmpleadoEditar').style.display = 'inline';
		document.getElementById('nombreEmpleadoEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombreEmpleadoEditar').style.display = 'none';
		document.getElementById('nombreEmpleadoEditar').style.border = "";
	}

	// Validacion para los apellidos
	if (apellidosEmpleadoEditar == "") {
		document.getElementById('errorApellidosEmpleadoEditar').style.display = 'inline';
		document.getElementById('apellidosEmpleadoEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorApellidosEmpleadoEditar').style.display = 'none';
		document.getElementById('apellidosEmpleadoEditar').style.border = "";
	}

	// Validacion par la fecha nacimiento
	if (fechaNacimientoEmpleadoEditar == "") {
		document.getElementById('errorFechaNacimientoEmpleadoEditar').style.display = 'inline';
		document.getElementById('fechaNacimientoEmpleado').style.border = "1px solid red";
	} else {
		document.getElementById('errorFechaNacimientoEmpleadoEditar').style.display = 'none';
		document.getElementById('fechaNacimientoEmpleadoEditar').style.border = "";
	}

	if (FechaNacimiento > hoy) {
		document.getElementById('errorFechaNacimientoSuperiorEditar').style.display = 'inline';
		document.getElementById('fechaNacimientoEmpleadoEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorFechaNacimientoSuperiorEditar').style.display = 'none';
		document.getElementById('fechaNacimientoEmpleadoEditar').style.border = "";
	}

	// Validacion para la direccion
	if (direccionEmpleadoEditar == "") {
		document.getElementById('errorDireccionEmpleadoEditar').style.display = 'inline';
		document.getElementById('direccionEmpleadoEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorDireccionEmpleadoEditar').style.display = 'none';
		document.getElementById('direccionEmpleadoEditar').style.border = "";
	}

	// Validacion para el telefono
	if (telefonoEmpleadoEditar == "") {
		document.getElementById('errorTelefonoEmpleadoEditar').style.display = 'inline';
		document.getElementById('telefonoEmpleadoEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorTelefonoEmpleado').style.display = 'none';
		document.getElementById('telefonoEmpleado').style.border = "";
	}

	// Validacion para el cargo
	if (cargoEmpleadoEditar == "Seleccione cargo") {
		document.getElementById('errorCargoEmpleadoEditar').style.display = 'inline';
		document.getElementById('cargoEmpleadoEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorCargoEmpleadoEditar').style.display = 'none';
		document.getElementById('cargoEmpleadoEditar').style.border = "";
	}

	if (nombreEmpleadoEditar != "" && apellidosEmpleadoEditar != ""
			&& rutEmpleadoEditar != "" && fechaNacimientoEmpleadoEditar != ""
			&& FechaNacimiento < hoy && direccionEmpleadoEditar != ""
			&& telefonoEmpleadoEditar != ""
			&& cargoEmpleadoEditar != "Seleccione cargo") {
		$
				.ajax({
					type : 'POST',
					url : "editarEmpleado",
					dataType : 'json',
					data : {
						rutEditar : rutEmpleadoEditar,
						nombreEditar : nombreEmpleadoEditar,
						apellidosEditar : apellidosEmpleadoEditar,
						fechaNacimientoEditar : fechaNacimientoEmpleadoEditar,
						direccionEditar : direccionEmpleadoEditar,
						telefonoEditar : telefonoEmpleadoEditar,
						cargoEditar : cargoEmpleadoEditar,
						claveEditar : claveEmpleadoEditar
					},
					success : function(data) {
						console.log(data);

						if (data == true) {

							// Actualizar el data table
							$
									.ajax({
										type : 'POST',
										url : "obtenerListaEmpleados",
										dataType : 'json',
										success : function(data) {

											if (!$.isEmptyObject(data)) {
												// vaciar datatable
												var oTable = $(
														'#listaEmpleados')
														.dataTable();
												oTable.fnClearTable();

												// Llenar data table
												for (var i = 0; i < data.length; i++) {
													$('#listaEmpleados')
															.dataTable()
															.fnAddData(

																	[
																			i + 1,
																			data[i].nombre,
																			data[i].apellidos,
																			data[i].rut,
																			data[i].direccion,
																			data[i].telefono,
																			data[i].cargo,
																			'<a href="#" onclick="editarEmpleado(\''
																					+ data[i].rut
																					+ '\');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarEmpleado(\''
																					+ data[i].rut
																					+ '\');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

															);
												}
											}

											// Close modal
											$('#modalEditarEmpleado').modal(
													'hide');

										},
										error : function(jqXHR, errorThrown) {
											toastr
													.error("Error al obtener los empleados");
										}
									});

							toastr.success("Empleado editado correctamente");

						} else {
							toastr.error("Error al editar el empleado");
						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al editar el empleado");
					}
				});
	}

}

$("input#rutEmpleado").rut({
	formatOn : 'keyup',
	minimumLength : 8, // validar largo mínimo; default: 2
	validateOn : 'change' // si no se quiere validar, pasar null
});

$('#listaEmpleados').DataTable({
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