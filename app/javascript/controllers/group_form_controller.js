import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['searchInput', 'userList', 'hiddenInput'];

  connect() {
    this.searchInputTarget.addEventListener('input', this.handleInput.bind(this));
  }

  handleInput() {
    const query = this.searchInputTarget.value.trim();

    if (query.length >= 3) {
      fetch(`/users/search?query=${query}`)
        .then(response => response.json())
        .then(users => {
          this.userListTarget.innerHTML = '';
          users.forEach(user => {
            const option = document.createElement('option');
            option.value = user.id;
            option.text = user.nickname;
            this.userListTarget.appendChild(option);
          });
        });
    } else {
      this.userListTarget.innerHTML = '';
    }
  }

  updateUserList(event) {
    const selectedOptions = Array.from(event.target.selectedOptions);
    const selectedUserIds = selectedOptions.map(option => option.value);
    this.hiddenInputTarget.value = selectedUserIds.join(',');
  }
}
