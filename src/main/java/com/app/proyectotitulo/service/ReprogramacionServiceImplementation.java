package com.app.proyectotitulo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.repository.ReprogramacionRepository;

@Service
public class ReprogramacionServiceImplementation implements ReprogramacionService {

	private ReprogramacionRepository reprogramacionRepo;

	@Autowired
	public void setReprogramacionRepository(ReprogramacionRepository reprogramacionRepository) {
		reprogramacionRepo = reprogramacionRepository;
	}
}