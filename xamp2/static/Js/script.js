document.addEventListener('DOMContentLoaded', () => {
  loadProducts();

  // Modal backdrop close
  window.addEventListener('click', (e) => {
    const modal = document.getElementById('productModal');
    if (e.target === modal) closeModal();
  });
});

function loadProducts() {
  fetch('/products')
    .then(res => res.json())
    .then(products => {
      const container = document.getElementById('product-container');
      container.innerHTML = '';

      products.forEach(product => {
        const card = document.createElement('div');
        card.className = 'product-card';

        const naira = Number(product.price).toLocaleString();
        const usd = Number(product.price_usd || 0).toFixed(2);

        card.innerHTML = `
          <img src="${product.image_url || 'https://via.placeholder.com/300'}" alt="${product.name}" />
          <div class="product-content">
            <h3>${product.name}</h3>
            <p>${product.description}</p>
            <p><strong>Type:</strong> ${product.subtype}</p>
            <p><strong>Batch:</strong> ${product.batch_no}</p>
            <p><strong>Expiry:</strong> ${product.expiry_date}</p>
            <p><strong>Quantity:</strong> ${product.quantity}</p>
            <p class="price">₦${naira} (~$${usd})</p>
          </div>
          <div class="buttons">
            <button class="btn edit-btn" onclick='openModal(true, ${JSON.stringify(product)})'>Edit</button>
            <button class="btn delete-btn" onclick='deleteProduct(${product.id})'>Delete</button>
          </div>
        `;
        container.appendChild(card);
      });
    })
    .catch(error => {
      console.error('Error loading products:', error);
      document.getElementById('product-container').innerHTML = '<p>Failed to load products.</p>';
    });
}

function openModal(isEdit = false, product = null) {
  const modal = document.getElementById('productModal');
  modal.style.display = 'flex';

  if (isEdit && product) {
    document.getElementById('name').value = product.name;
    document.getElementById('description').value = product.description;
    document.getElementById('price').value = product.price;
    document.getElementById('price_usd').value = product.price_usd || '';
    document.getElementById('batch_no').value = product.batch_no;
    document.getElementById('expiry_date').value = product.expiry_date;
    document.getElementById('quantity').value = product.quantity;
    document.getElementById('subtype').value = product.subtype;
    document.getElementById('image_url').value = product.image_url;
    modal.setAttribute('data-edit-id', product.id);
  } else {
    clearForm();
    modal.removeAttribute('data-edit-id');
  }
}

function closeModal() {
  document.getElementById('productModal').style.display = 'none';
}

function clearForm() {
  document.querySelectorAll('#productModal input').forEach(input => input.value = '');
}

function saveProduct() {
  const product = {
    name: document.getElementById('name').value,
    description: document.getElementById('description').value,
    price: parseFloat(document.getElementById('price').value),
    price_usd: parseFloat(document.getElementById('price_usd').value || 0),
    batch_no: document.getElementById('batch_no').value,
    expiry_date: document.getElementById('expiry_date').value,
    quantity: parseInt(document.getElementById('quantity').value),
    subtype: document.getElementById('subtype').value,
    image_url: document.getElementById('image_url').value
  };

  const editId = document.getElementById('productModal').getAttribute('data-edit-id');
  const method = editId ? 'PUT' : 'POST';
  const url = editId ? `/products/${editId}` : '/products';

  fetch(url, {
    method: method,
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(product)
  })
    .then(res => res.json())
    .then(data => {
      closeModal();
      loadProducts();
      alert(data.message);
    })
    .catch(err => alert('Something went wrong: ' + err.message));
}

function deleteProduct(id) {
  if (confirm('Delete this product?')) {
    fetch(`/products/${id}`, { method: 'DELETE' })
      .then(res => res.json())
      .then(data => {
        alert(data.message);
        loadProducts();
      });
  }
}
