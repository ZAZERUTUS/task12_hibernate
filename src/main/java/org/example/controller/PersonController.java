package org.example.controller;

import org.example.model.Person;
import org.example.service.PersonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/api")
public class PersonController {

    @Autowired
    private PersonService personService;

    @GetMapping("/persons")
    public Page<Person> getAllPersons(@RequestParam(defaultValue = "0") int page,
                                      @RequestParam(defaultValue = "15") int size) {
        return personService.getAllPersons(PageRequest.of(page, size));
    }

    @GetMapping("/persons/{personId}")
    public Person getPersonById(@PathVariable Long personId) {
        return personService.getPersonById(personId);
    }

    @PostMapping("/persons")
    public Person createPerson(@RequestBody Person person) {
        return personService.createPerson(person);
    }

    @PutMapping("/persons/{personId}")
    public Person updatePerson(@PathVariable Long personId, @RequestBody Person updatedPerson) {
        return personService.updatePerson(personId, updatedPerson);
    }

    @DeleteMapping("/persons/{personId}")
    public void deletePerson(@PathVariable Long personId) {
        personService.deletePerson(personId);
    }
}
