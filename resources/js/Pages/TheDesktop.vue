<template>
  <div class="h-screen w-screen">
    <main>


      <div class="w-min relative">
        <div class="overflow-hidden opacity-0 resize"></div>

        <div class="x">
          ✖
          <span>drag the spot!</span>
        </div>
      </div>


        <div class="resize overflow-auto p-3 border rounded">
          <iframe
              width="100%"
              height="100%"
              src="https://www.openstreetmap.org/export/embed.html?bbox=-0.004017949104309083%2C51.47612752641776%2C0.00030577182769775396%2C51.478569861898606&layer=mapnik">
          </iframe>
        </div>
    </main>
  </div>
</template>

<script setup>
</script>