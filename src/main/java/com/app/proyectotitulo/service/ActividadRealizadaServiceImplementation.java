package com.app.proyectotitulo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.repository.ActividadRealizadaRepository;

@Service
public class ActividadRealizadaServiceImplementation implements ActividadRealizadaService {

	private ActividadRealizadaRepository actividadRealizadaRepo;

	@Autowired
	public void setActividadRealizadaRepository(ActividadRealizadaRepository actividadRealizadaRepository) {
		actividadRealizadaRepo = actividadRealizadaRepository;
	}

}
