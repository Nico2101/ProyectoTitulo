function agregarInsumo() {
	$('#modalAgregarInsumo').modal('show');

	// Limpiar modal
	$('#nombreInsumo').val("");
	$('#marcaInsumo').val("");
	$("#tipoInsumo").val(-1);
	$("#umInsumo").val(-1);

	document.getElementById('errorUM').style.display = 'none';
	document.getElementById('umInsumo').style.border = "";

	document.getElementById('errorTipo').style.display = 'none';
	document.getElementById('tipoInsumo').style.border = "";

	document.getElementById('errorNombre').style.display = 'none';
	document.getElementById('nombreInsumo').style.border = "";
}

function guardarDatosInsumo() {
	// Obtener los datos
	var nombreInsumo = $('#nombreInsumo').val();

	var tipo = document.getElementById("tipoInsumo");
	var tipoSeleccionado = tipo.options[tipo.selectedIndex].text;

	var um = document.getElementById("umInsumo");
	var umSeleccionado = um.options[um.selectedIndex].text;

	var marca = $('#marcaInsumo').val();

	console.log(nombreInsumo);
	console.log(tipoSeleccionado);
	console.log(umSeleccionado);

	// Validacion para el nombre
	if (nombreInsumo == "") {
		document.getElementById('errorNombre').style.display = 'inline';
		document.getElementById('nombreInsumo').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombre').style.display = 'none';
		document.getElementById('nombreInsumo').style.border = "";
	}

	// Validacion para el tipo
	if (tipoSeleccionado == "Seleccione Tipo") {
		document.getElementById('errorTipo').style.display = 'inline';
		document.getElementById('tipoInsumo').style.border = "1px solid red";
	} else {
		document.getElementById('errorTipo').style.display = 'none';
		document.getElementById('tipoInsumo').style.border = "";
	}

	// Validacion para la unidad de medida
	if (umSeleccionado == "Seleccione Unidad de Medida") {
		document.getElementById('errorUM').style.display = 'inline';
		document.getElementById('umInsumo').style.border = "1px solid red";
	} else {
		document.getElementById('errorUM').style.display = 'none';
		document.getElementById('umInsumo').style.border = "";
	}

	if (nombreInsumo != "" && tipoSeleccionado != "Seleccione Tipo"
			&& umSeleccionado != "Seleccione Unidad de Medida") {
		$
				.ajax({
					type : 'POST',
					url : "agregarInsumo",
					dataType : 'json',
					data : {
						nombre : nombreInsumo,
						tipo : tipoSeleccionado,
						um : umSeleccionado,
						marca : marca
					},
					success : function(data) {
						console.log(data);

						if (data.idInsumo > 0) {
							$('#modalAgregarInsumo').modal('hide');

							// Actualizar el data table
							$
									.ajax({
										type : 'POST',
										url : "obtenerListaInsumos",
										dataType : 'json',
										success : function(data) {

											if (!$.isEmptyObject(data)) {
												// vaciar datatable
												var oTable = $('#listaInsumos')
														.dataTable();
												oTable.fnClearTable();

												// Llenar data table
												for (var i = 0; i < data.length; i++) {
													$('#listaInsumos')
															.dataTable()
															.fnAddData(

																	[
																			i + 1,
																			data[i].nombre,
																			data[i].tipo,
																			data[i].unidadMedida,
																			data[i].marca,
																			'<a href="#" onclick="editarInsumo('
																					+ data[i].idInsumo
																					+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarInsumo('
																					+ data[i].idInsumo
																					+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

															);
												}
											}

											// Close modal
											$('#modalEditarInsumo').modal(
													'hide');

										},
										error : function(jqXHR, errorThrown) {
											toastr
													.error("Error al obtener los insumos");
										}
									});

							toastr.success("Insumo agregado correctamente");
						} else {
							toastr.error("Error al agregar el insumo");
						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al agregar el insumo");
					}
				});
	}

}

function editarInsumo(idInsumo) {
	console.log(idInsumo);

	if (idInsumo > 0) {
		// Obtener los datos del insumo
		$
				.ajax({
					type : 'POST',
					url : "obtenerInsumoAEditar",
					dataType : 'json',
					data : {
						idInsumo : idInsumo
					},
					success : function(data) {
						console.log(data);
						if (!$.isEmptyObject(data)) {
							// Cargar los datos en el modal
							$('#nombreInsumoEditar').val(data.nombre);
							$('#marcaInsumoEditar').val(data.marca);

							$('#tipoInsumoEditar').empty();
							$('#umInsumoEditar').empty();

							// obtengo los option de tipo insumo
							var tipoInsumo = $('#tipoInsumo option');

							for (var i = 0; i < tipoInsumo.length; i++) {
								if (tipoInsumo[i].innerText == data.tipo) {
									$("#tipoInsumoEditar").append(
											'<option value='
													+ tipoInsumo[i].value
													+ ' selected>'
													+ tipoInsumo[i].innerText
													+ '</option>');
								} else {
									$("#tipoInsumoEditar").append(
											'<option value='
													+ tipoInsumo[i].value + '>'
													+ tipoInsumo[i].innerText
													+ '</option>');
								}

							}

							// obtengo los option de um insumo
							var umInsumo = $('#umInsumo option');

							for (var j = 0; j < umInsumo.length; j++) {
								if (umInsumo[j].innerText == data.unidadMedida) {
									$("#umInsumoEditar").append(
											'<option value='
													+ umInsumo[j].value
													+ ' selected>'
													+ umInsumo[j].innerText
													+ '</option>');
								} else {
									$("#umInsumoEditar").append(
											'<option value='
													+ umInsumo[j].value + '>'
													+ umInsumo[j].innerText
													+ '</option>');
								}

							}

							document.getElementById('errorUMEditar').style.display = 'none';
							document.getElementById('umInsumoEditar').style.border = "";

							document.getElementById('errorTipoEditar').style.display = 'none';
							document.getElementById('tipoInsumoEditar').style.border = "";

							document.getElementById('errorNombreEditar').style.display = 'none';
							document.getElementById('nombreInsumoEditar').style.border = "";

							// Cargar el id del insumo en el input oculto
							$('#idInsumoEditar').val(idInsumo);

							$('#modalEditarInsumo').modal('show');

						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al editar el insumo");
					}
				});
	}

}

function eliminarInsumo(idInsumo) {
	console.log(idInsumo);

	if (idInsumo > 0) {
		swal(
				{
					title : "¿Está seguro de eliminar el insumo?",
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
								url : "eliminarInsumo",
								dataType : 'json',
								data : {
									idInsumo : idInsumo
								},
								success : function(data) {
									if (data == true) {
										swal.close();
										toastr
												.success("Insumo eliminado correctamente");

										// Actualizar el data table
										$
												.ajax({
													type : 'POST',
													url : "obtenerListaInsumos",
													dataType : 'json',
													success : function(data) {

														if (!$
																.isEmptyObject(data)) {
															// vaciar datatable
															var oTable = $(
																	'#listaInsumos')
																	.dataTable();
															oTable
																	.fnClearTable();

															// Llenar data table
															for (var i = 0; i < data.length; i++) {
																$(
																		'#listaInsumos')
																		.dataTable()
																		.fnAddData(

																				[
																						i + 1,
																						data[i].nombre,
																						data[i].tipo,
																						data[i].unidadMedida,
																						data[i].marca,
																						'<a href="#" onclick="editarInsumo('
																								+ data[i].idInsumo
																								+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarInsumo('
																								+ data[i].idInsumo
																								+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

																		);
															}
														}

													},
													error : function(jqXHR,
															errorThrown) {
														toastr
																.error("Error al obtener los insumos");
													}
												});
									} else {
										toastr
												.error("Error al obtener los insumos");
									}

								},
								error : function(jqXHR, errorThrown) {
									toastr.error("Error al eliminar el insumo");
								}
							});

				});
	}

}

function guardarDatosInsumoEditar() {
	// Obtener los datos
	var nombreInsumo = $('#nombreInsumoEditar').val();

	var tipo = document.getElementById("tipoInsumoEditar");
	var tipoSeleccionado = tipo.options[tipo.selectedIndex].text;

	var um = document.getElementById("umInsumoEditar");
	var umSeleccionado = um.options[um.selectedIndex].text;

	var marca = $('#marcaInsumoEditar').val();

	var idInsumo = $('#idInsumoEditar').val();

	console.log(nombreInsumo);
	console.log(tipoSeleccionado);
	console.log(umSeleccionado);

	// Validacion para el nombre
	if (nombreInsumo == "") {
		document.getElementById('errorNombreEditar').style.display = 'inline';
		document.getElementById('nombreInsumoEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorNombreEditar').style.display = 'none';
		document.getElementById('nombreInsumoEditar').style.border = "";
	}

	// Validacion para el tipo
	if (tipoSeleccionado == "Seleccione Tipo") {
		document.getElementById('errorTipoEditar').style.display = 'inline';
		document.getElementById('tipoInsumoEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorTipoEditar').style.display = 'none';
		document.getElementById('tipoInsumoEditar').style.border = "";
	}

	// Validacion para la unidad de medida
	if (umSeleccionado == "Seleccione Unidad de Medida") {
		document.getElementById('errorUMEditar').style.display = 'inline';
		document.getElementById('umInsumoEditar').style.border = "1px solid red";
	} else {
		document.getElementById('errorUMEditar').style.display = 'none';
		document.getElementById('umInsumoEditar').style.border = "";
	}

	if (nombreInsumo != "" && tipoSeleccionado != "Seleccione Tipo"
			&& umSeleccionado != "Seleccione Unidad de Medida" && idInsumo > 0) {
		$
				.ajax({
					type : 'POST',
					url : "editarInsumo",
					dataType : 'json',
					data : {
						idInsumo : idInsumo,
						nombre : nombreInsumo,
						tipo : tipoSeleccionado,
						um : umSeleccionado,
						marca : marca
					},
					success : function(data) {
						console.log(data);

						if (data == true) {

							// Actualizar el data table
							$
									.ajax({
										type : 'POST',
										url : "obtenerListaInsumos",
										dataType : 'json',
										success : function(data) {

											if (!$.isEmptyObject(data)) {
												// vaciar datatable
												var oTable = $('#listaInsumos')
														.dataTable();
												oTable.fnClearTable();

												// Llenar data table
												for (var i = 0; i < data.length; i++) {
													$('#listaInsumos')
															.dataTable()
															.fnAddData(

																	[
																			i + 1,
																			data[i].nombre,
																			data[i].tipo,
																			data[i].unidadMedida,
																			data[i].marca,
																			'<a href="#" onclick="editarInsumo('
																					+ data[i].idInsumo
																					+ ');"><i class="fa fa-edit fa-lg" style="color: #1CE4D0"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="eliminarInsumo('
																					+ data[i].idInsumo
																					+ ');"><i class="fa fa-trash-o fa-lg" style="color: red"></i></a>' ]

															);
												}
											}

											// Close modal
											$('#modalEditarInsumo').modal(
													'hide');

										},
										error : function(jqXHR, errorThrown) {
											toastr
													.error("Error al obtener los insumos");
										}
									});

							toastr.success("Insumo editado correctamente");

						} else {
							toastr.error("Error al editar el insumo");
						}

					},
					error : function(jqXHR, errorThrown) {
						toastr.error("Error al editar el insumo");
					}
				});
	}

}

$('#listaInsumos').DataTable({
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