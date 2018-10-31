function nombrePredioVacio() {
	nombreSector = $('#nombrePredio').val();

	document.getElementById('errorNombre').style.display = 'none';
	document.getElementById('nombrePredio').style.border = "";

}

function sectorNoSeleccionado() {
	nombreSector = $('#sectorSeleccionado').val();

	document.getElementById('errorSector').style.display = 'none';
	document.getElementById('sectorSeleccionado').style.border = "";

}

function superficiePredioVacia() {
	nombreSector = $('#superficiePredio').val();

	document.getElementById('errorSuperficie').style.display = 'none';
	document.getElementById('superficiePredio').style.border = "";

}

function agregarPredio() {
	$('#modalAgregarPredio').modal('show');

	// Limpiar modal
	$('#nombrePredio').val("");
	$('#sectorSeleccionado').val(-1);
	$('#idinput1').val("");
	$('#idinput2').val("");
	$('#idinput3').val("");
	$("#superficiePredio").val("");

	document.getElementById('errorNombre').style.display = 'none';
	document.getElementById('nombrePredio').style.border = "";

	document.getElementById('errorSector').style.display = 'none';
	document.getElementById('sectorSeleccionado').style.border = "";

	document.getElementById('errorSuperficieNegativa').style.display = 'none';
	document.getElementById('superficiePredio').style.border = "";

	document.getElementById('errorSuperficie').style.display = 'none';
	document.getElementById('superficiePredio').style.border = "";

	document.getElementById('errorSubTotal').style.display = 'none';
	document.getElementById('superficiePredio').style.border = "";

	document.getElementById('errorSuperficieNoPuedeSerCero').style.display = 'none';
	document.getElementById('superficiePredio').style.border = "";

	document.getElementById('mostrar').style.display = 'none';
}

function superficieTotalPredios() {
	var idSector = $("#sectorSeleccionado").val();
	$("#idinput1").val("");
	$("#idinput2").val("");
	$("#idinput3").val("");
	console.log(idSector);

	if (idSector > 0) {
		// habilita los input
		document.getElementById('mostrar').style.display = 'inline';

		// obtengo el total de la superficie del sector

		$.ajax({
			type : 'POST',
			url : "obtenerTotalSuperficeSector",
			dataType : 'json',
			async : false,
			data : {
				idSector : idSector
			},
			success : function(data) {
				$("#idinput1").val(data);
				console.log(data);

			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener la superficie del sector");
			}

		});

		$.ajax({
			type : 'POST',
			url : "obtenerTotalSuperficePrediosSector",
			dataType : 'json',
			async : false,
			data : {
				idSector : idSector
			},
			success : function(data) {
				$("#idinput2").val(data);
				console.log(data);

			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener la superficie utilizada del sector");
			}
		});

		// superficie disponile
		var input1 = $("#idinput1").val();
		var input2 = $("#idinput2").val();
		var primerInput = parseInt(input1);
		var segundoInput = parseInt(input2);

		$("#idinput3").val(primerInput - segundoInput);

		// desactiva el input de superficie cuando superficie disponible =0
		var sup = document.getElementById('superficiePredio');
		if ($("#idinput3").val() == 0) {
			sup.disabled = true;
		} else {
			sup.disabled = false;
		}

	}

}

function superficieTotalPrediosEditar() {
	var idSector = $("#sectorEditar").val();
	$("#totalSector").val("");
	$("#totalPredios").val("");
	$("#superficieDisponible").val("");

	console.log(idSector);

	if (idSector > 0) {

		// obtengo el total de la superficie del sector

		$.ajax({
			type : 'POST',
			url : "obtenerTotalSuperficeSector",
			dataType : 'json',
			async : false,
			data : {
				idSector : idSector
			},
			success : function(data) {
				$("#totalSector").val(data);
				console.log(data);

			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener la superficie del sector");
			}

		});

		$.ajax({
			type : 'POST',
			url : "obtenerTotalSuperficePrediosSector",
			dataType : 'json',
			async : false,
			data : {
				idSector : idSector
			},
			success : function(data) {
				$("#totalPredios").val(data);
				console.log(data);

			},
			error : function(jqXHR, errorThrown) {
				alert("Error al obtener la superficie utilizada del sector");
			}
		});

		// superficie disponile
		var totalSECTOR = $("#totalSector").val();
		var totalPREDIOS = $("#totalPredios").val();
		var totalSector = parseInt(totalSECTOR);
		var totalPredios = parseInt(totalPREDIOS);

		$("#superficieDisponible").val(totalSector - totalPredios);

		// desactiva el input de superficie cuando superficie disponible =0
		var Sup = document.getElementById('superficieEditar');
		if ($("#superficieDisponible").val() == 0) {
			Sup.disabled = true;
		} else {
			Sup.disabled = false;
		}

	}

}

function guardarDatosPredio() {

	// Obtener los datos
	var nombrePredio = $('#nombrePredio').val();

	var idSector = $("#sectorSeleccionado").val();

	var superficie = $('#superficiePredio').val();

	// para obtener la superficie disponible
	var input1 = $("#idinput1").val();
	var input2 = $("#idinput2").val();
	var totalSuperficieSector = parseInt(input1);
	var totalSuperficiePredios = parseInt(input2);

	console.log(nombrePredio);
	console.log(idSector);
	console.log(superficie);

	// Validacion para el nombre del predio
	if (nombrePredio == "") {
		document.getElementById('errorNombre').style.display = 'inline';
		document.getElementById('nombrePredio').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombre').style.display = 'none';
		document.getElementById('nombrePredio').style.border = "";
	}

	// Validacion para el sector donde se ubica el predio
	if (idSector == -1) {
		document.getElementById('errorSector').style.display = 'inline';
		document.getElementById('sectorSeleccionado').style.border = "1px solid red";
	} else {
		document.getElementById('errorSector').style.display = 'none';
		document.getElementById('sectorSeleccionado').style.border = "";
	}

	// Validacion para la superficie del predio a agregar
	if (superficie == "") {
		document.getElementById('errorSuperficieNoPuedeSerCero').style.display = 'none';
		document.getElementById('errorSuperficie').style.display = 'inline';
		document.getElementById('superficiePredio').style.border = "1px solid red";
	} else {

		if (superficie < 0) {
			document.getElementById('errorSuperficie').style.display = 'none';
			document.getElementById('errorSuperficieNegativa').style.display = 'inline';
			document.getElementById('superficiePredio').style.border = "1px solid red";
		} else {
			document.getElementById('errorSuperficieNegativa').style.display = 'none';
			document.getElementById('superficiePredio').style.border = "";
		}

		if (superficie == 0) {
			document.getElementById('errorSuperficie').style.display = 'none';
			document.getElementById('errorSuperficieNoPuedeSerCero').style.display = 'inline';
			document.getElementById('superficiePredio').style.border = "1px solid red";
		} else {
			document.getElementById('errorSuperficieNoPuedeSerCero').style.display = 'none';
			document.getElementById('superficiePredio').style.border = "";
		}

	}
	if (superficie != "" && superficie > 0) {
		document.getElementById('errorSuperficie').style.display = 'none';
		document.getElementById('superficiePredio').style.border = "";
	}

	// valida cuando la superficie ingresada es superior a la disponible
	if (superficie > (($('#idinput1').val()) - ($('#idinput2').val()))) {
		document.getElementById('errorSubTotal').style.display = 'inline';
		document.getElementById('superficiePredio').style.border = "1px solid red";
	} else {
		document.getElementById('errorSubTotal').style.display = 'none';
		document.getElementById('superficiePredio').style.border = "";
	}

	if (($('#idinput3').val()) == 0) {
		document.getElementById('errorSuperficie').style.display = 'none';
		document.getElementById('superficiePredio').style.border = "";
	}

	if (($('#idinput3').val()) == 0 && nombrePredio != "" && idSector != -1) {
		toastr.error("Error no se puede agregar predio en el sector indicado");

	}

	if (nombrePredio != "" && superficie > 0
			&& superficie <= (totalSuperficieSector - totalSuperficiePredios)) {

		$
				.ajax({
					type : 'POST',
					url : "verificarNombreRepetidoPredio",
					dataType : 'json',
					async : false,
					data : {
						nombre : nombrePredio
					},
					success : function(data) {
						if (data == true) {
							swal(
									{
										title : "Ya existe un predio con el nombre ingresado ¿Desea continuar?",
										text : "",
										type : "warning",
										showCancelButton : true,
										confirmButtonClass : "btn-danger",
										cancelButtonText : "Cancelar",
										confirmButtonText : "Si, Seguro",
										closeOnConfirm : false
									},
									function() {

										$
												.ajax({
													type : 'POST',
													url : "agregarPredio",
													dataType : 'json',
													data : {
														nombre : nombrePredio,
														superficie : superficie,
														idSector : idSector,

													},
													success : function(data) {
														swal.close();
														console.log(data);

														if (data.idPredio > 0) {
															$(
																	'#modalAgregarPredio')
																	.modal(
																			'hide');

															// Actualizar el
															// data table
															$
																	.ajax({
																		type : 'POST',
																		url : "obtenerListaPredios",
																		dataType : 'json',
																		success : function(
																				data) {

																			if (!$
																					.isEmptyObject(data)) {
																				// vaciar
																				// datatable
																				var oTable = $(
																						'#listaPredios')
																						.dataTable();
																				oTable
																						.fnClearTable();

																				// Llenar
																				// data
																				// table
																				for (var i = 0; i < data.length; i++) {
																					$(
																							'#listaPredios')
																							.dataTable()
																							.fnAddData(

																									[
																											i + 1,
																											data[i].nombre,
																											data[i].superficie,
																											data[i].sector.nombre,
																											'<a href="#" onclick="editarPredio('
																													+ data[i].idPredio
																													+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarPredio('
																													+ data[i].idPredio
																													+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																							);
																				}
																			}

																		},
																		error : function(
																				jqXHR,
																				errorThrown) {
																			toastr
																					.error("Error al obtener los predios");
																		}
																	});

															toastr
																	.success("Predio agregado correctamente");
														} else {
															toastr
																	.error("Error al agregar el predio");
														}

													},
													error : function(jqXHR,
															errorThrown) {
														toastr
																.error("Error al agregar el predio");
													}
												});

									});
						} else {
							$
									.ajax({
										type : 'POST',
										url : "agregarPredio",
										dataType : 'json',
										data : {
											nombre : nombrePredio,
											superficie : superficie,
											idSector : idSector,

										},
										success : function(data) {
											console.log(data);

											if (data.idPredio > 0) {
												$('#modalAgregarPredio').modal(
														'hide');

												// Actualizar el data table
												$
														.ajax({
															type : 'POST',
															url : "obtenerListaPredios",
															dataType : 'json',
															success : function(
																	data) {

																if (!$
																		.isEmptyObject(data)) {
																	// vaciar
																	// datatable
																	var oTable = $(
																			'#listaPredios')
																			.dataTable();
																	oTable
																			.fnClearTable();

																	// Llenar
																	// data
																	// table
																	for (var i = 0; i < data.length; i++) {
																		$(
																				'#listaPredios')
																				.dataTable()
																				.fnAddData(

																						[
																								i + 1,
																								data[i].nombre,
																								data[i].superficie,
																								data[i].sector.nombre,
																								'<a href="#" onclick="editarPredio('
																										+ data[i].idPredio
																										+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarPredio('
																										+ data[i].idPredio
																										+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																				);
																	}
																}

															},
															error : function(
																	jqXHR,
																	errorThrown) {
																toastr
																		.error("Error al obtener los predios");
															}
														});

												toastr
														.success("Predio agregado correctamente");
											} else {
												toastr
														.error("Error al agregar el predio");
											}

										},
										error : function(jqXHR, errorThrown) {
											toastr
													.error("Error al agregar el predio");
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

function editarPredio(idPredio) {
	console.log(idPredio);

	if (idPredio > 0) {
		// Obtener los datos del predio a editar

		$
				.ajax({
					type : 'POST',
					url : "obtenerPredioAEditar",
					dataType : 'json',
					data : {
						idPredio : idPredio
					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {
							// Cargar los datos en el modal
							$('#nombrePredioEditar').val(data.nombre);
							$('#superficieEditar').val(data.superficie);

							$('#sectorEditar').empty();

							// obtengo los option de los sectores
							var idSector = $('#sectorSeleccionado option');

							for (var i = 0; i < idSector.length; i++) {
								if (idSector[i].innerText == data.sector.nombre) {
									$("#sectorEditar").append(
											'<option value='
													+ idSector[i].value
													+ ' selected>'
													+ idSector[i].innerText
													+ '</option>');
								} else {
									$("#sectorEditar").append(
											'<option value='
													+ idSector[i].value + '>'
													+ idSector[i].innerText
													+ '</option>');
								}

							}

							// permite mostrar la superficie del sector, ocupada
							// y disponible.
							var IDsector = $("#sectorEditar").val();
							if (IDsector > 0) {

								// obtengo el total de la superficie del sector

								$
										.ajax({
											type : 'POST',
											url : "obtenerTotalSuperficeSector",
											dataType : 'json',
											async : false,
											data : {
												idSector : IDsector
											},
											success : function(data) {
												$("#totalSector").val(data);
												console.log(data);

											},
											error : function(jqXHR, errorThrown) {
												alert("Error al obtener la superficie del sector");
											}

										});

								$
										.ajax({
											type : 'POST',
											url : "obtenerTotalSuperficePrediosSector",
											dataType : 'json',
											async : false,
											data : {
												idSector : IDsector
											},
											success : function(data) {
												$("#totalPredios")
														.val(
																data
																		- $(
																				'#superficieEditar')
																				.val());
												console.log(data);

											},
											error : function(jqXHR, errorThrown) {
												alert("Error al obtener la superficie utilizada del sector");
											}
										});
							}

							// superficie disponile
							var TOTALsector = $("#totalSector").val();
							var TOTALpredios = $("#totalPredios").val();
							var totalSECTOR = parseInt(TOTALsector);
							var totalPREDIOS = parseInt(TOTALpredios);

							$("#superficieDisponible").val(
									totalSECTOR - totalPREDIOS);

							if (($('#sectorEditar').val()) == -1) {
								document.getElementById('errorSectorEditar').style.display = 'inline';
								document.getElementById('sectorEditar').style.border = "1px solid red";

							} else {
								document.getElementById('errorSectorEditar').style.display = 'none';
								document.getElementById('sectorEditar').style.border = "";
							}

							document.getElementById('errorNombreEditar').style.display = 'none';
							document.getElementById('nombrePredioEditar').style.border = "";

							document
									.getElementById('errorSuperficieNegativaEditar').style.display = 'none';
							document.getElementById('superficieEditar').style.border = "";

							document.getElementById('errorSuperficieEditar').style.display = 'none';
							document.getElementById('superficieEditar').style.border = "";

							document.getElementById('errorSubTotalEditar').style.display = 'none';
							document.getElementById('superficieEditar').style.border = "";

							document
									.getElementById('errorSuperficieNoPuedeSerCeroEditar').style.display = 'none';
							document.getElementById('superficieEditar').style.border = "";

							// Cargar el id del predio en el input oculto
							$('#idPredioEditar').val(idPredio);

							$('#modalEditarPredio').modal('show');

						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al editar el predio");
					}
				});

	}

}

function eliminarPredio(idPredio) {
	console.log(idPredio);

	if (idPredio > 0) {
		swal(
				{
					title : "¿Está seguro de eliminar el predio?",
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
								url : "eliminarPredio",
								dataType : 'json',
								data : {
									idPredio : idPredio
								},
								success : function(data) {
									if (data == true) {
										swal.close();
										toastr
												.success("Predio eliminado correctamente");

										// Actualizar el data table
										$
												.ajax({
													type : 'POST',
													url : "obtenerListaPredios",
													dataType : 'json',
													success : function(data) {

														if (!$
																.isEmptyObject(data)) {
															// vaciar datatable
															var oTable = $(
																	'#listaPredios')
																	.dataTable();
															oTable
																	.fnClearTable();

															// Llenar data table
															for (var i = 0; i < data.length; i++) {
																$(
																		'#listaPredios')
																		.dataTable()
																		.fnAddData(

																				[
																						i + 1,
																						data[i].nombre,
																						data[i].superficie,
																						data[i].sector.nombre,
																						'<a href="#" onclick="editarPredio('
																								+ data[i].idPredio
																								+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarPredio('
																								+ data[i].idPredio
																								+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																		);
															}
														}

													},
													error : function(jqXHR,
															errorThrown) {
														toastr
																.error("Error al obtener los predios");
													}
												});
									} else {
										toastr
												.error("Error al obtener los predios");
									}

								},
								error : function(jqXHR, errorThrown) {
									toastr.error("Error al eliminar el predio");
								}
							});

				});
	}

}

function guardarDatosPredioEditar() {
	// Obtener los datos
	var nombrePredioEditar = $('#nombrePredioEditar').val();

	var idSector = $("#sectorEditar").val();

	var superficieEditar = $('#superficieEditar').val();

	var totalSuperficieSector = $('#totalSector').val();
	var totalSuperficiePredios = $('#totalPredios').val();
	var superficieDisponible = $('#superficieDisponible').val();

	var idPredio = $('#idPredioEditar').val();

	console.log(nombrePredio);
	console.log(idSector);
	console.log(superficieEditar);

	// Validacion para el nombre del predio
	if (nombrePredioEditar == "") {
		document.getElementById('errorNombreEditar').style.display = 'inline';
		document.getElementById('nombrePredioEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombreEditar').style.display = 'none';
		document.getElementById('nombrePredioEditar').style.border = "";
	}

	// Validacion para el sector donde se ubica el predio
	if (idSector == -1) {
		document.getElementById('errorSectorEditar').style.display = 'inline';
		document.getElementById('sectorEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorSectorEditar').style.display = 'none';
		document.getElementById('sectorEditar').style.border = "";
	}

	// Validacion para la superficie del predio a agregar
	if (superficieEditar == "") {
		document.getElementById('errorSuperficieNoPuedeSerCeroEditar').style.display = 'none';
		document.getElementById('errorSuperficieEditar').style.display = 'inline';
		document.getElementById('superficieEditar').style.border = "1px solid red";
	} else {

		if (superficieEditar < 0) {
			document.getElementById('errorSuperficieNegativaEditar').style.display = 'inline';
			document.getElementById('superficieEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorSuperficieNegativaEditar').style.display = 'none';
			document.getElementById('superficieEditar').style.border = "";
		}

		if (superficieEditar == 0) {
			document.getElementById('errorSuperficieEditar').style.display = 'none';
			document.getElementById('errorSuperficieNoPuedeSerCeroEditar').style.display = 'inline';
			document.getElementById('superficieEditar').style.border = "1px solid red";
		} else {
			document.getElementById('errorSuperficieNoPuedeSerCeroEditar').style.display = 'none';
			document.getElementById('superficieEditar').style.border = "";
		}

	}
	if (superficieEditar != "" && superficieEditar > 0) {
		document.getElementById('errorSuperficieEditar').style.display = 'none';
		document.getElementById('errorSubTotalEditar').style.display = 'none';
		document.getElementById('superficieEditar').style.border = "";
	}

	// cuando la superficie ingresada es superior a la disponible
	if (superficieEditar > (superficieDisponible)) {
		document.getElementById('errorSubTotalEditar').style.display = 'inline';
		document.getElementById('superficieEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorSubTotalEditar').style.display = 'none';
		document.getElementById('superficieEditar').style.border = "";
	}

	if (superficieDisponible == 0) {
		document.getElementById('errorSubTotalEditar').style.display = 'none';
		document.getElementById('superficieEditar').style.border = "";
		toastr
				.error("Error no se puede agregar predio en el sector seleccionado");
	}

	if (nombrePredioEditar != "" && superficieEditar > 0 && idPredio > 0
			&& superficieEditar <= (superficieDisponible)) {
		$
				.ajax({
					type : 'POST',
					url : "editarPredio",
					dataType : 'json',
					data : {
						idPredio : idPredio,
						nombre : nombrePredioEditar,
						superficie : superficieEditar,
						idSector : idSector,

					},
					success : function(data) {
						console.log(data);

						if (data == true) {

							// Actualizar el data table
							$
									.ajax({
										type : 'POST',
										url : "obtenerListaPredios",
										dataType : 'json',
										success : function(data) {

											if (!$.isEmptyObject(data)) {
												// vaciar datatable
												var oTable = $('#listaPredios')
														.dataTable();
												oTable.fnClearTable();

												// Llenar data table
												for (var i = 0; i < data.length; i++) {
													$('#listaPredios')
															.dataTable()
															.fnAddData(

																	[
																			i + 1,
																			data[i].nombre,
																			data[i].superficie,
																			data[i].sector.nombre,
																			'<a href="#" onclick="editarPredio('
																					+ data[i].idPredio
																					+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarPredio('
																					+ data[i].idPredio
																					+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

															);
												}
												toastr
														.success("Predio editado correctamente");
											}

											// Close modal
											$('#modalEditarPredio').modal(
													'hide');

										},
										error : function(jqXHR, errorThrown) {
											toastr
													.error("Error al obtener predios");
										}
									});

						} else {
							toastr.error("Error al editar el predio");
						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al editar prediooooo");
					}
				});
	}

}

function filterFloat(evt, input) {

	var key = window.Event ? evt.which : evt.keyCode;
	var chark = String.fromCharCode(key);
	var tempValue = input.value + chark;
	if (key >= 48 && key <= 57) {
		if (filter(tempValue) === false) {
			return false;
		} else {
			return true;
		}
	} else {
		if (key == 8 || key == 13 || key == 0) {
			return true;
		} else if (key == 46) {
			if (filter(tempValue) === false) {
				return false;
			} else {
				return true;
			}
		} else {
			return false;
		}
	}
}

function filter(__val__) {
	var preg = /^\d*$/;
	if (preg.test(__val__) === true) {
		return true;
	} else {
		return false;
	}

}

$('#listaPredios').DataTable({
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