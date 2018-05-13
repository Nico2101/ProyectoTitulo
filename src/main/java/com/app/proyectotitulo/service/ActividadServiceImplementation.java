package com.app.proyectotitulo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.domain.Actividad;
import com.app.proyectotitulo.repository.ActividadRepository;

@Service
public class ActividadServiceImplementation implements ActividadService {

	private ActividadRepository actividadRepo;

	@Autowired
	public void setActividadRepository(ActividadRepository actividadRepository) {
		actividadRepo = actividadRepository;
	}

	@Override
	public void save(Actividad a) {
		// TODO Auto-generated method stub
		actividadRepo.save(a);
	}
}
