package com.app.proyectotitulo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.repository.ActividadInsumoRepository;

@Service
public class ActividadInsumoServiceImplementation implements ActividadInsumoService {

	private ActividadInsumoRepository actividadInsumoRepo;

	@Autowired
	public void setActividadInsumoRepository(ActividadInsumoRepository actividadInsumoRepository) {
		actividadInsumoRepo = actividadInsumoRepository;
	}

}
