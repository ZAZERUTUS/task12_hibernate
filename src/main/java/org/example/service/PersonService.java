package org.example.service;

import org.example.model.House;
import org.example.model.Person;
import org.example.repository.HouseRepository;
import org.example.repository.PersonRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.persistence.EntityNotFoundException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class PersonService {

    @Autowired
    private PersonRepository personRepository;

    @Autowired
    private HouseRepository houseRepository;

    public Page<Person> getAllPersons(Pageable pageable) {
        return personRepository.findAll(pageable);
    }

    public Person getPersonById(Long personId) {
        return personRepository.findById(personId)
                .orElseThrow(() -> new EntityNotFoundException("Person not found with id: " + personId));
    }

    public void deletePerson(Long personId) {
        personRepository.deleteById(personId);
    }

    public List<Person> getResidentsByHouse(House house) {
        return personRepository.findByHouse(house);
    }

    public Person createPerson(Person person) {
        person.setCreateDate(LocalDateTime.now());
        person.setUpdateDate(LocalDateTime.now());
        return personRepository.save(person);
    }

    public Person updatePerson(Long personId, Person updatedPerson) {
        Person existingPerson = personRepository.findById(personId)
                .orElseThrow(() -> new RuntimeException("Person not found with id " + personId));

        if (!existingPerson.equals(updatedPerson)) {
            existingPerson.setName(updatedPerson.getName());
            existingPerson.setSurname(updatedPerson.getSurname());
            existingPerson.setSex(updatedPerson.getSex());
            existingPerson.setPassportSeries(updatedPerson.getPassportSeries());
            existingPerson.setPassportNumber(updatedPerson.getPassportNumber());
            existingPerson.setUpdateDate(LocalDateTime.now());
        }

        return personRepository.save(existingPerson);
    }

    public List<House> getOwnedHousesByPersonId(Long personId) {
        Person person = personRepository.findById(personId)
                .orElseThrow(() -> new RuntimeException("Person not found with id " + personId));
        return new ArrayList<>(person.getOwnedHouses());
    }

    public List<Person> getResidentsByHouseId(Long houseId) {
        House house = houseRepository.findById(houseId)
                .orElseThrow(() -> new RuntimeException("House not found with id " + houseId));
        return personRepository.findByHouse(house);
    }
}